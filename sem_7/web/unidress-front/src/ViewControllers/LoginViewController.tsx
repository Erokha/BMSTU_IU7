import React from 'react';
import AuthService from "../Services/AuthService";
import {Navigate} from "react-router-dom";
import {AuthServiceLoginData, AuthServiceRegisterData} from "../Services/AuthService";
import "./LoginStyles.css"

interface LoginProps {
}

interface LoginViewControllerState {
    login: string;
    username: string;
    password: string;
    passwordRepeat: string;
    isLoading: boolean;
    navigationFinished: boolean;
}


class LoginViewController extends React.Component <LoginProps, LoginViewControllerState> {
    constructor(props: LoginProps) {
        super(props);
        this.state = {
            username: "",
            login: "",
            password: "",
            passwordRepeat: "",
            isLoading: false,
            navigationFinished: false
        };
    }

    async onClick() {
        if (!this.validate()) {
            return
        }
        let data: AuthServiceRegisterData = {
            username: this.state.username,
            login: this.state.login,
            password: this.state.password
        }


        try {
            let response = await AuthService.register(data)
            this.setState({navigationFinished: true})
        } catch (error) {
            alert(`error is ${error}`)
        }
        this.forceUpdate()
    }

    render() {
        if (this.state.navigationFinished) {
            return this.finishLogin()
        }
        return (
            <div className="main-login-container">
                <p className="registry-title"> Регистрация </p>
                <input
                    type="text"
                    placeholder="Придумайте никнейм"
                    className="input-form"
                    onChange={event => {
                        this.handleUsernameFieldChange(event.target.value)
                    }}
                />
                <input
                    type="text"
                    placeholder="Придумайте логин"
                    className="input-form"
                    onChange={event => {
                        this.handleLoginFieldChange(event.target.value)
                    }}
                />
                <input
                    type="password"
                    placeholder="Придумайте пароль"
                    className="input-form"
                    onChange={event => {
                        this.handlePasswordFieldChange(event.target.value)
                    }}
                />
                <input
                    type="password"
                    placeholder="Повторите пароль"
                    className="input-form"
                    onChange={event => {
                        this.handlePasswordRepeatChange(event.target.value)
                    }}
                />
                <button
                    className="input-form"
                    onClick={
                        async () => {
                            await this.onClick()
                        }
                    }
                > Регистрация
                </button>
            </div>

        )
    }

    private finishLogin() {
        return (
            <Navigate to='/profile'/>
        )
    }

    private handleUsernameFieldChange(newUsername: string) {
        this.setState({username: newUsername})
    }

    private handleLoginFieldChange(newLogin: string) {
        this.setState({login: newLogin})
    }

    private handlePasswordFieldChange(newPassword: string) {
        this.setState({password: newPassword})
    }

    private handlePasswordRepeatChange(newPasswordRepeat: string) {
        this.setState({passwordRepeat: newPasswordRepeat})
    }

    private validate(): boolean {
        if (this.state.login.length <= 4) {
            alert("Логин должен быть длиннее 4 символов")
            return false
        }
        if (this.state.username.length <= 4) {
            alert("Никнейм должен быть длиннее 4 символов")
            return false
        }
        if (!this.passwordsMatches()) {
            return false
        }
        return true
    }

    private passwordsMatches(): boolean {
        if (this.state.password === this.state.passwordRepeat) {
            return true
        } else {
            return false
        }
    }
}

export default LoginViewController;