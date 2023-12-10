
import React, { useState } from 'react'
import "./popup.css"
import {GiCancel} from "react-icons/gi"
const Popup = ({closepopup}) => {
  const [noti, setnoti] = useState(false)


    const handleClick=()=>{
        closepopup()
    }
    const successNoti=()=>{
      setnoti(true)
      
    }
    
  return (
    <div className="con-home-popup" onClick={()=>{}}>
      {

        
        noti && <>
        <div className="main" style={{display:"flex",width:"100%",justifyContent:"space-between"}}>

        <h2 style={{color:"green"}}>Success</h2>
        <GiCancel className='cross' onClick={handleClick}/>
        </div>
         <strong>You will soon receive notification on the status of your document</strong> 
        </>
      }
      {
        !noti &&<>
         <div className="popup-header">

<h3>Upload File</h3>
<GiCancel className='cross' onClick={handleClick}/>
</div>
<div className="popup-content">
 
<input type="file" name="" id="" />
<button onClick={successNoti}>Upload</button>
</div>
        </>
        
      }
    </div>
  )
    }

export default Popup