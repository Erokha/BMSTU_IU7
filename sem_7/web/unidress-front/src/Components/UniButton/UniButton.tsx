import React from 'react';
import './UniButton.css'

interface UniButtonProps {
    title: string;
    onClick: () => void;
}

interface UniButtonState {
    title: string;
    onClick: () => void;
}

class UniButton extends React.Component <UniButtonProps, UniButtonState>  {
    constructor(props: UniButtonProps) {
        super(props);
        this.state = {
            title: props.title,
            onClick: props.onClick,
        }
    }

    render() {
        return (
            <div className="uniButton">
                <button className="button" onClick={() => {this.props.onClick()}}>
                    {this.state.title}
                </button>
            </div>
        )
    }
}
export default UniButton;