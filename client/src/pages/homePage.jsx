
import React, { useState } from 'react'
import Popup from '../components/popup/popup'

import "./home.css"
import Nav from '../components/popup/nav'
const HomePage = () => {
    const [popup, setpopup] = useState(false)
    const close=()=>{
        setpopup(false)
    }
    const runbserver=()=>{
        fetch('http://localhost:3001/execute', {
      method: 'POST',
      
    })
      .then((response) => {
        if (response.ok) {
          // Handle successful response here
          return response.json(); // Parse the JSON response
        } else {
          // Handle error response
          return response.json().then(errorData => {
            throw new Error(`${errorData.msg}`);
          });
        }
      })
      .then((responseData) => {
        
      })
      .catch((error) => {
       console.log(error.message)
      });
    }
  return (
    <div className="con-home">
        {popup && <Popup closepopup={()=>close()}/>}
        <Nav/>
        <div className="box-home">
           

            <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Accusamus ratione nulla quasi at dolorem, ipsa ut quia maxime enim labore soluta provident dignissimos voluptatem tenetur sunt optio error debitis, necessitatibus commodi architecto.</p>
            <div className="box-btns"><button onClick={()=> setpopup(true)}>Add</button> <button onClick={runbserver}>Verify</button></div>
        </div>
        <div className="parth">
                    <h3>Partners</h3>
                </div>
            <div className="con-partners">
                
                <div className="partner">
                   
                    <p className='p-name'>Scroll</p>

                </div>
                <div className="partner">
                    
                    <p className='p-name'>Airstack</p>

                </div>
                <div className="partner">
                   
                    <p className='p-name'>Polygon</p>
                    
                </div>

            </div>
        
    </div>
  )
}

export default HomePage