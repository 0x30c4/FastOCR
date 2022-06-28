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
                    Fast and Free OCR service. Extract text from <br/>
                    any image with in few seconds. Simple Optical <br/>
                    Character Recognition service. Maximum File <br/>
                    upload size is 8MB. <br/>
                    The <a href="https://github.com/0x30c4/fastOCR/">GitHub Repo</a> link. <br/>
                    API <a href="https://ocr.0x30c4.dev/api/docs">Documentation</a> link.
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
