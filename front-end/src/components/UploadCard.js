import React from 'react';
import {
        Card, CardBody, CardText, CardImg, CardTitle,
        CardHeader, Button, FormGroup, Progress
} from 'reactstrap';
import { ToastContainer, toast } from 'react-toastify';


export default function UploadCard( { onChangeHandler, onClickHandler, loaded} ) {
    return (
        <Card >
            <CardHeader>
                <h2>
                    Upload An Image
                </h2>
            </CardHeader>
            <CardBody>
                <CardText>
                    Fast and Free OCR service.
                    Extract text from any image with in few seconds.
                    Simple Optical Character Recognition service.
                    Maximum File upload size is 8MB.
                </CardText>
                <FormGroup>
                    <input type="file" className="form-control" onChange={onChangeHandler}/>
                </FormGroup>
                <Button variant="primary" onClick={onClickHandler}>Upload</Button>
                <ToastContainer />
                <br/>
                <Progress max="100" color="success" value={loaded} >{Math.round(loaded,2) }%</Progress>
            </CardBody>
        </Card>
    );
}
