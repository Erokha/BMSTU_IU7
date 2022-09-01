import React from 'react';
import './UserCard.css'
import UniButton from "../UniButton/UniButton";

interface UserCardProps {
    img: string;
    title: string;
    subtitle: string;
}

interface UserCardState {
    img: string;
    title: string;
    subtitle: string;
}



class UserCard extends React.Component <UserCardProps, UserCardState>  {
    constructor(props: UserCardProps) {
        super(props);
        this.state = {
            img: props.img,
            title: props.title,
            subtitle: props.subtitle
        }
    }

    render() {
        return (
            <div className="user-card-container">
                <div className="user-card-image-container">
                    <img src={this.state.img} className="user-card-image"/>
                </div>
                <h3 className="user-card-title">{this.state.title}</h3>
                <p className="user-card-subtitle">{this.state.subtitle}</p>
                <div className="user-card-button-container">
                    <UniButton title={"Jopa"} onClick={() => {}}/>
                </div>
            </div>
        )
    }
}
export default UserCard;