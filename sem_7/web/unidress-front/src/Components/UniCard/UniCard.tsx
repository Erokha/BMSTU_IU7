import React from 'react';
import './UniCard.css'
import UniButton from "../UniButton/UniButton";

interface UniCardProps {
    imageURL: string;
    minorTitle: string
    mainTitle: string;
    minorSubtitle?: string;
    mainSubtitle?: string;
    buttonText?: string;
    onClick?: () => void;
}

interface UniCardState {
    buttonText?: string;
    onClick?: () => void;
    buttonAvaliable: boolean;
}

class UniCard extends React.Component <UniCardProps, UniCardState>  {
    constructor(props: UniCardProps) {
        super(props);
        this.state = {
            buttonText: props.buttonText,
            onClick: props.onClick,
            buttonAvaliable: props.onClick != null,
        }
    }

    render() {
        return (
            <div className="uni-card-container">
                <div className="image-view-container">
                    <img
                        className="card-image"
                        src={this.props.imageURL}
                    />
                </div>

                <p className="minor-title">{this.props.minorTitle}</p>
                <p className="main-title">{this.props.mainTitle}</p>
                <div className="button-container">
                    <UniButton title="button" onClick={() => { alert("Писька")}}/>
                </div>
            </div>
        )
    }
}
export default UniCard;