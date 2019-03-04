class List < ApplicationRecord
  belongs_to :boards
  has_many :tasks

  def self.all_lists(user_id)
    List.find_by_sql(
      "SELECT *
      FROM boards AS b
      WHERE b.user_id = #{user_id}"
    )
  end


def self.single_board(list_id)
  List.find_by_sql(["
    SELECT * 
    FROM boards AS b
    WHERE b.id = ?
  ", list_id]).first
end

def self.create_board(p, id)
  List.find_by_sql(["
    INSERT INTO lists (name, user_id, created_at, updated_at)
    VALUES (:name, :user_id, :created_at, :updated_at);
  ", {
    name: p[:name],
    user_id: id,
    created_at: DateTime.now,
    updated_at: DateTime.now
  }])
end
   

def self.update_board(list_id, p)
  List.find_by_sql(["
    UPDATE lists AS b
    SET name = ?, updated_at = ?
    WHERE b.id = ?
  ;", p[:name], DateTime.now, list_id])
end

def self.delete_board(list_id)
  BList.find_by_sql(["
    DELETE FROM listsAS b
    WHERE b.id = ?
  ;", list_id])
end
end
