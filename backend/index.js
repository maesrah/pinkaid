const express = require("express");

const app= express();

app.use(express.json());

app.use(express.urlencoded({
    extended:true
}));

app.listen(2000,()=>{
    console.log("Connected to server at 2000");
})

const doctorData = [];

app.post("/api/addDoctors", (req, res) => {
    console.log("Result", req.body);
  
    const newDoctors = req.body.map((doctor, index) => {
      return {
        id: doctorData.length + index + 1,
        fullName: doctor.fullName,
        position: doctor.position,
        workExperience: doctor.workExperience,
        hospitalWork: doctor.hospitalWork,
        profImage: doctor.profImage,
      };
    });
  
    // Add all new doctors to doctorData
    doctorData.push(...newDoctors);
  
    console.log("Final", newDoctors);
  
    res.status(200).send({
     
      "status.code": 200,
      "message": "Doctors added successfully",
      "doctors": newDoctors,
    });

    
  });

  app.get("/api/addDoctors", (req, res) => {
    res.status(200).send({
       doctorData
    });
});


 

//post api



  