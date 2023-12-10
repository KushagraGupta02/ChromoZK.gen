
import React, { useState } from 'react'
import Popup from '../components/popup/popup'

import "./home.css"
import Nav from '../components/popup/nav'
import Sk from "../assets/sketch.jpg"
const HomePage = () => {
    const [popup, setpopup] = useState(false)
    const close=()=>{
        setpopup(false)
    }
    const runbserver=()=>{
        fetch('http://localhost:3003/execute', {
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
        {popup && <div className="overlay" ><Popup closepopup={()=>close()}/></div>}
        <Nav/>
        <img src={Sk} alt="" height={"400px"} width={"400px"} style={{margin:"10px auto"}}/>
        <div className="box-home">
           

            <p>We present ZKin.gen - our novel decentralised ancestry detection framework, which is completely onchain! #ETHIndia 2023 Project for zkZombies</p>
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
                    
                    <p className='p-name'>Push Protocol</p>

                </div>
                <div className="partner">
                   
                    <p className='p-name'>Alliance</p>
                    
                </div>
                <div className="partner">
                   
                    <p className='p-name'>File Coin</p>
                    
                </div>

            </div>
        
    </div>
  )
}

export default HomePage