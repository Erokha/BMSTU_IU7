import React from 'react';
import logo from './logo.svg';
import './App.css';
import UserCard from './Components/UserCard/UserCard';
import LoginViewController from './ViewControllers/LoginViewController'
import UniButton from "./Components/UniButton/UniButton";
import {
    BrowserRouter,
    Routes,
    Route,
    Link,
    Outlet
} from 'react-router-dom'

function App() {
    return (
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<UniButton  onClick={() => {}} title={"jopa"}/>} />
                <Route path="/register" element={<LoginViewController />}/>
                <Route path="/profile" element={<UniButton  onClick={() => {}} title={"jopa"}/>}>
                </Route>
            </Routes>
        </BrowserRouter>
  );
}

export default App;
