require 'pg'
require 'sinatra'
require 'pry'


def db_connection
  begin
    connection = PG.connect(dbname: 'things_to_do')
    yield(connection)
  ensure
    connection.close
  end
end


get '/' do

  dl_monday = 'Monday'
  dl_tuesday = 'Tuesday'
  dl_wednesday = 'Wednesday'
  dl_thursday = 'Thursday'
  dl_friday = 'Friday'
  dl_saturday = 'Saturday'
  dl_sunday = 'Sunday'
  dl_short_term = 'Short Term'
  dl_long_term = 'Long Term'

  sql = "SELECT id, name FROM things_to_do WHERE deadline = $1"
    @sql_monday = db_connection do |db|
      db.exec(sql,[dl_monday])
    end

  sql = "SELECT id, name FROM things_to_do WHERE deadline = $1"
    @sql_tuesday = db_connection do |db|
      db.exec(sql,[dl_tuesday])
    end

  sql = "SELECT id, name FROM things_to_do WHERE deadline = $1"
    @sql_wednesday = db_connection do |db|
      db.exec(sql,[dl_wednesday])
    end

  sql = "SELECT id, name FROM things_to_do WHERE deadline = $1"
  @sql_thursday = db_connection do |db|
    db.exec(sql,[dl_thursday])
  end

  sql = "SELECT id, name FROM things_to_do WHERE deadline = $1"
  @sql_friday = db_connection do |db|
    db.exec(sql,[dl_friday])
  end

  sql = "SELECT id, name FROM things_to_do WHERE deadline = $1"
  @sql_saturday = db_connection do |db|
    db.exec(sql,[dl_saturday])
  end

  sql = "SELECT id, name FROM things_to_do WHERE deadline = $1"
  @sql_sunday = db_connection do |db|
    db.exec(sql,[dl_sunday])
  end

  sql = "SELECT id, name FROM things_to_do WHERE deadline = $1"
  @sql_short_term = db_connection do |db|
    db.exec(sql,[dl_short_term])
  end

  sql = "SELECT id, name FROM things_to_do WHERE deadline = $1"
  @sql_long_term = db_connection do |db|
    db.exec(sql,[dl_long_term])
  end

  erb :main
end


post '/take_a_task' do

  @task = params["task"]
  @deadline = params["deadline"]

  sql = "INSERT INTO things_to_do (name, deadline) VALUES ($1, $2)"
  db_connection do |db|
    db.exec(sql, [@task,@deadline])
  end

  redirect '/'

end

post '/delete_tasks' do

  array_of_ids = params.keys

  array_of_ids.each do |x|

    sql = "DELETE FROM things_to_do WHERE id = $1"
      db_connection do |db|
      db.exec(sql, [x])
    end

  end

  redirect '/'

end

#do a count to see how mayn you've completed
