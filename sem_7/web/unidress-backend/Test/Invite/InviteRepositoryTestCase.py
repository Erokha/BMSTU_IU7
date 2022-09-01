from Repositories.InviteRepository import InviteRepository
from Repositories.UserRepository import UserRepository
from Repositories.WardrobeRepository import WardrobeRepository
from Test.Builders.UserBuilder import UserBuilder
from Test.Builders.WardrobeBuilder import WardrobeBuilder
from Test.DatabaseCleaner import DatabaseCleaner
from config import test_db_filename

DB_NAME = test_db_filename


def clean_database(f):
    def decorated_function(*args, **kwargs):
        DatabaseCleaner(DB_NAME).clean()
        return f(*args, **kwargs)

    return decorated_function


def register_erokha(f):
    def decorated_function(*args, **kwargs):
        user_repo = UserRepository(DB_NAME, False)
        builder = UserBuilder()
        builder.with_name("Nikita Erokhin").with_login("erokha").with_password("123456")
        user_repo.register_user(*builder.build_register_data())
        return f(*args, **kwargs)

    return decorated_function


def register_zak(f):
    def decorated_function(*args, **kwargs):
        user_repo = UserRepository(DB_NAME, False)
        builder = UserBuilder().with_name("Alexandr Zakharov").with_login("sashazak").with_password("123456")
        user_repo.register_user(*builder.build_register_data())
        return f(*args, **kwargs)

    return decorated_function


@clean_database
@register_erokha
@register_zak
def test_correct_invite():
    invite_repo = InviteRepository(DB_NAME, False)
    wardrobe_repo = WardrobeRepository(DB_NAME, False)
    wardrobe_builder = WardrobeBuilder().with_name("gucci gang").with_creator_login('erokha').with_description('A')

    _, id = wardrobe_repo.create_wardrobe(*wardrobe_builder.build_create_data())
    result, error = invite_repo.inviteUser('erokha', 'sashazak', id)

    assert error is False
    assert result == {'status': "OK"}

@clean_database
@register_erokha
def test_incorrect_invite():
    invite_repo = InviteRepository(DB_NAME, False)

    erokha_builder = UserBuilder().with_name("Nikita Erokhin").with_login("erokha").with_password("123456")

    expect = {"status": "error", "reason": "no such user or wardrobe"}


    response, error = invite_repo.inviteUser("this user does not exits", erokha_builder.login, 123)

    assert error
    assert response == expect

@clean_database
@register_erokha
@register_zak
def test_no_such_wardrobe():
    invite_repo = InviteRepository(DB_NAME, False)
    wardrobe_repo = WardrobeRepository(DB_NAME, False)

    wardrobe_builder = WardrobeBuilder() \
        .with_name("gucci gang").with_creator_login('erokha').with_description("No comment")

    expect = {"status": "error", "reason": "no such user or wardrobe"}


    _, id = wardrobe_repo.create_wardrobe(*wardrobe_builder.build_create_data())

    response, error = invite_repo.inviteUser('erokha', 'sashazak', id + 5)

    assert error
    assert response == expect


@clean_database
@register_erokha
@register_zak
def test_corrent_get_invites():
    invite_repo = InviteRepository(DB_NAME, False)
    wardrobe_repo = WardrobeRepository(DB_NAME, False)

    wardrobe_builder = WardrobeBuilder() \
        .with_name("gucci gang").with_creator_login('erokha').with_description("No comment")
    _, id = wardrobe_repo.create_wardrobe(*wardrobe_builder.build_create_data())
    invite_repo.inviteUser('erokha', 'sashazak', id)

    expect = [{'invite_id': 1, 'login_that_invites': 'erokha', 'wardrobe_name': 'gucci gang', 'image_url': None}]
    response = invite_repo.get_invites_by_login('sashazak')

    assert response == expect

@clean_database
@register_erokha
def test_empty_invites():
    invite_repo = InviteRepository(DB_NAME, False)

    expect = []
    response = invite_repo.get_invites_by_login('erokha')

    assert response == expect