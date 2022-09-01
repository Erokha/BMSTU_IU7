import axios, {AxiosResponse} from "axios";

const API_URL = "http://localhost:8000/";

export interface AuthServiceLoginData {
    username: string;
    password: string;
}

export interface AuthServiceRegisterData {
    login: string;
    username: string;
    password: string;
}

export interface AuthServiceRegisterResponse {
    user_name: string
    image_url: string
    login: string
}

class AuthService {
    // MARK: - Public
    public login(data: AuthServiceLoginData) {
        return axios
        let object = {
            "username": data.username,
            "password": data.password
        }
        axios.post(API_URL + "signin", object)
            .then(response => {
                return response.data;
            });
    }

    public async register(data: AuthServiceRegisterData): Promise<AuthServiceRegisterResponse> {
        let object = {
            "login": data.login,
            "username": data.username,
            "password": data.password
        }
        try {
            return await axios.post(API_URL + "register", object)
        } catch (error: any) {
            throw Error(error)
        }
    }

    public getCurrentUser() {
        const userStr = localStorage.getItem("user");
        if (userStr) return JSON.parse(userStr);

        return null;
    }
}

export default new AuthService();
