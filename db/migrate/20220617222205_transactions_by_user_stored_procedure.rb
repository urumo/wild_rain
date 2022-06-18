# frozen_string_literal: true

class TransactionsByUserStoredProcedure < ActiveRecord::Migration[7.0]
  def change
    sql = <<~SQL
      create type transaction_type as enum ('sender', 'receiver');
      create type transaction_by_user_result as
      (
          id               uuid,
          tt               transaction_type,
          sender_id        uuid,
          receiver_id      uuid,
          amount           numeric(32, 8),
          current_user_had numeric(32, 8),
          current_user_has numeric(32, 8),
          other_user_had   numeric(32, 8),
          other_user_has   numeric(32, 8),
          created_at       timestamp(6)
      );

      create or replace function transactions_by_user(in user_id uuid, in begin_date timestamp, in end_date timestamp)
          returns setof transaction_by_user_result
          language plpgsql
      as
      $BODY$
      declare
          tr     record;
          cu_had numeric(32, 8);
          cu_has numeric(32, 8);
          ou_had numeric(32, 8);
          ou_has numeric(32, 8);
          tt     transaction_type;
      begin
          create temporary table if not exists temp_transactions
          (
              id               uuid,
              tt               transaction_type,
              sender_id        uuid,
              receiver_id      uuid,
              amount           numeric(32, 8),
              current_user_had numeric(32, 8),
              current_user_has numeric(32, 8),
              other_user_had   numeric(32, 8),
              other_user_has   numeric(32, 8),
              created_at       timestamp(6)
          );

          delete from temp_transactions;

          for tr in select *
                    from transactions
                    where (sender_id = user_id
                        or receiver_id = user_id)
                      and (created_at > begin_date and created_at <= end_date)
              LOOP
                  if tr.receiver_id = user_id
                  then
                      cu_had := tr.receiver_had;
                      cu_has := tr.receiver_has;
                      ou_had := tr.sender_had;
                      ou_has := tr.sender_has;
                      tt := 'receiver';
                  else
                      cu_had := tr.sender_had;
                      cu_has := tr.sender_had;
                      ou_had := tr.receiver_has;
                      ou_has := tr.receiver_has;
                      tt := 'sender';
                  end if;
                  insert into temp_transactions (id, tt, sender_id, receiver_id, amount, current_user_had, current_user_has,
                                                 other_user_had, other_user_has, created_at)
                  values (tr.id,
                          tt,
                          tr.sender_id,
                          tr.receiver_id,
                          tr.amount,
                          cu_had,
                          cu_has,
                          ou_had,
                          ou_has,
                          tr.created_at);
              end LOOP;

          return query select * from temp_transactions order by created_at;
      end;
      $BODY$;
    SQL

    execute sql
  end
end
