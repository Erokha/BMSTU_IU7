import Repositories.InviteRepository as invite_repo
import Repositories.ItemRepository as item_repo
import Repositories.UserRepository as user_repo

class AccessManager:
    item_repository: item_repo.IItemRepository
    invite_repository: invite_repo.IInviteRepository
    user_repository: user_repo.IUserRepository

    def __init__(
            self,
            item_repository: item_repo.IItemRepository,
            invite_repository: invite_repo.IInviteRepository,
            user_repository: user_repo.IUserRepository
    ):
        self.item_repository = item_repository
        self.invite_repository = invite_repository
        self.user_repository = user_repository

    def check_user_auth(self, login, password):
        info = self.user_repository.get_user_info(login, password)
        if info == None:
            return False
        return True


    def user_has_access_to_item(self, login, item_id) -> bool:
        item = self.item_repository.get_item_by_id(item_id)
        try:
            if item["owner_login"] == login:
                return True
        except Exception:
            pass
        try:
            wardrobe_ids = self.item_repository.get_wardrobes_ids_contains_item(item_id)
            for id in wardrobe_ids:
                for editor in self.invite_repository.get_wardrobe_editors(id):
                    if editor["login"] == login:
                        return True
        except Exception:
            pass
        return False


def make_access_manager() -> AccessManager:
    return AccessManager(
        item_repo.ItemRepository(),
        invite_repo.InviteRepository(),
        user_repo.UserRepository(enable_log=False)
    )


# manager = AccessManager(
#     item_repo.ItemRepository(enable_log=False),
#     invite_repo.InviteRepository(enable_log=False),
#     user_repo.UserRepository(enable_log=False)
# )
# manager.user_has_access_to_item('sashazak', 1)
