from Repositories.UserRepository import UserRepository
from Test.DatabaseCleaner import DatabaseCleaner
from Test.Builders.UserBuilder import UserBuilder

DB_NAME = "/Users/erokha/unidress/test_db.sqlite"

def test_correct_register_user():
    DatabaseCleaner(DB_NAME).clean()
    user_repo = UserRepository(DB_NAME, False)
    builder = UserBuilder().with_name("Nikita Erokhin").with_login("erokha").with_password("123456")
    expect = {'user_name': 'Nikita Erokhin', 'image_id': None, 'image_url': None, 'login': 'erokha'}
    response, error = user_repo.register_user(*builder.build_register_data())
    assert error == False
    assert response == expect

def test_correct_login_user():
    DatabaseCleaner(DB_NAME).clean()
    user_repo = UserRepository(DB_NAME, False)
    builder = UserBuilder().with_name("Nikita Erokhin").with_login("erokha").with_password("123456")

    user_repo.register_user(*builder.build_register_data())

    expect = {'user_name': 'Nikita Erokhin', 'image_id': None, 'image_url': None, 'login': 'erokha'}
    response = user_repo.get_user_info(*builder.build_login_data())
    assert response == expect

def test_correct_change_username():
    DatabaseCleaner(DB_NAME).clean()
    user_repo = UserRepository(DB_NAME, False)
    username = "erokha"
    new_name = "Not Nikita Erokhin"
    status = user_repo.user_change_name(username, new_name)
    assert status == "OK"

def test_incorrect_login():
    DatabaseCleaner(DB_NAME).clean()
    user_repo = UserRepository(DB_NAME, False)
    username = "sashazak"
    password = "asovnaaknfdv"
    response = user_repo.get_user_info(username, password)
    assert response is None

def test_assert_renew_register():
    DatabaseCleaner(DB_NAME).clean()
    user_repo = UserRepository(DB_NAME, False)
    builder = UserBuilder().with_name("Nikita Erokhin").with_login("erokha").with_password("123456")
    user_repo.register_user(*builder.build_register_data())
    response, error = user_repo.register_user(*builder.build_register_data())
    assert error == True
