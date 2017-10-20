class Task
  attr_accessor :id, :title, :description, :done

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    @done = attributes[:done] || false
  end

  def self.all
    results = DB.execute("SELECT * FROM tasks;")
    results.map { |result| build_task(result) }
  end

  def self.find(id)
    result = DB.execute("SELECT * FROM tasks WHERE id = ?", id).first
    build_task(result)
  end

  def save
    @id ? update : insert
  end

  def delete
    DB.execute("DELETE FROM tasks WHERE id = ?", id)
  end

  private

  def self.build_task(result)
    Task.new(id: result["id"], title: result["title"], description: result["description"], done: (result["done"] == 0 ? false : true))
  end

  def insert
    DB.execute("INSERT INTO tasks (title, description, done) VALUES (?, ?, ?)", title, description, (done == false ? 0 : 1) )
    @id = DB.last_insert_row_id
  end

  def update
    DB.execute("UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?", title, description, (done == false ? 0 : 1), id)
  end
end
