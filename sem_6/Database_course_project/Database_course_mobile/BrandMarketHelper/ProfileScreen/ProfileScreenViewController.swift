import UIKit
import PinLayout

final class ProfileScreenViewController: UIViewController {
	var output: ProfileScreenViewOutput?
    let userImageView = UIImageView()
    let domainNameLabel = UILabel()
    let tableView = UITableView()
    let imagePicker = UIImagePickerController()
    let hiddenButton = UIButton()

	override func viewDidLoad() {
		super.viewDidLoad()
        buildUI()
        output?.didLoadView()
	}
    
    override func viewDidLayoutSubviews() {
        layoutUI()
    }
    
    @objc private func addImageAction() {
        chooseHowToPickImage()
    }
}

extension ProfileScreenViewController {
    private func buildUI() {
        buildView()
        buildUserImageView()
        buildDomainNameLabel()
        buildTableView()
        buildHiddenButton()
        buildImagePicker()
    }
    
    private func layoutUI() {
        layoutUserImageView()
        layoutDomainNameLabel()
        layoutTableView()
        layoutHiddenButton()
    }
    
    private func buildView() {
        view.backgroundColor = .systemBackground
    }
    
    private func buildUserImageView() {
        userImageView.contentMode = .scaleAspectFill
        userImageView.tintColor = .label
        view.addSubview(userImageView)
    }
    
    private func layoutUserImageView() {
        userImageView.pin
            .width(150)
            .height(150)
            .hCenter()
            .top(8%)
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userImageView.clipsToBounds = true
    }
    
    private func buildHiddenButton() {
        hiddenButton.addTarget(self, action: #selector(addImageAction), for: .touchUpInside)
        hiddenButton.backgroundColor = .clear
        view.addSubview(hiddenButton)
    }
    
    private func layoutHiddenButton() {
        hiddenButton.pin
            .width(150)
            .height(150)
            .hCenter()
            .top(8%)
    }
    
    private func buildDomainNameLabel() {
        domainNameLabel.textAlignment = .center
        domainNameLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        view.addSubview(domainNameLabel)
    }
    
    private func layoutDomainNameLabel() {
        domainNameLabel.pin
            .left(20)
            .right(20)
            .height(30)
            .top(to: userImageView.edge.bottom).marginTop(20)
    }
    
    private func buildTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableViewRegisterCells()
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        view.addSubview(tableView)
    }
    
    private func layoutTableView() {
        tableView.pin
            .left(10)
            .right(10)
            .bottom()
            .top(to: domainNameLabel.edge.bottom).marginTop(20)
    }
    
    private func buildImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    private func layoutImagePicker() {
        
    }
}

extension ProfileScreenViewController: ProfileScreenViewInput {
    func updateInfo() {
        domainNameLabel.text = output?.model?.displayName
        BrandMarketImageProvider.shared.getImage(
            url: output?.model?.imageURL,
            placeholder: BrandImage.avatarPlaceholder.image?.withTintColor(.label)) { [weak self] reponse in
            switch reponse {
            case .success(let image):
                self?.userImageView.image = image
            case .failure(_):
                self?.userImageView.image = BrandImage.person.image
            }
        }
        tableView.reloadData()
    }
    
}

extension ProfileScreenViewController: UITableViewDelegate, UITableViewDataSource {
    private func tableViewRegisterCells() {
        tableView.register(
            ProfileScreenDefaultSection.self,
            forCellReuseIdentifier: ProfileScreenDefaultSection.reuseIdentifier
        )
        tableView.register(
            ProfileScreenButtonSection.self,
            forCellReuseIdentifier: ProfileScreenButtonSection.reuseIdentifier
        )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        output?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 7
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let output = output else { return UITableViewCell() }
        let model = output.cellViewModels[indexPath.section]
        let resolver = ProfileScreenResolver(model: model, tableView: tableView, index: indexPath)
        return resolver.resolve()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let output = output else {
            return
        }
        output.cellViewModels[indexPath.section].action?()
    }
}

extension ProfileScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func action(
        for type: UIImagePickerController.SourceType,
        title: String
    ) -> UIAlertAction? {
        return UIAlertAction(title: title, style: .default) {[unowned self] _ in
            imagePicker.sourceType = type
            present(self.imagePicker, animated: true)
        }
    }

    private func chooseHowToPickImage() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if let action = self.action(for: .camera, title: "Camera") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Photo library") {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        let data = image?.jpegData(compressionQuality: 1)
        output?.handleImageData(data: data)
        controller.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickerController(picker, didSelect: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            pickerController(picker, didSelect: nil)
            return
        }
        pickerController(picker, didSelect: image)
    }
}
