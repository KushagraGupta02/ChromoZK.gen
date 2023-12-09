
import React from 'react'
import "./popup.css"
import {GiCancel} from "react-icons/gi"
const Popup = ({closepopup}) => {

    const handleClick=()=>{
        closepopup()
    }
  return (
    <div className="con-home-popup">
        <div className="popup-header">

        <h3>Upload File</h3>
        <GiCancel className='cross' onClick={handleClick}/>
        </div>
        <div className="popup-content">
         
        <input type="file" name="" id="" />
        <button>Upload</button>
        </div>
    </div>
  )
}

export default Popup