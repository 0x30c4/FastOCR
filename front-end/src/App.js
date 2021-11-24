import axios from 'axios';
import React, {Component} from 'react';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import ImgCard from './components/ImgCard';
import UploadCard from './components/UploadCard';
import {
        Container, Label, Button,
        Row, Col, FormGroup
} from 'reactstrap';


export default class App extends Component {;

    host = window.location.protocol + "//" + window.location.host
    imgQuery = false

    constructor(props) {
        super(props);
            this.state = {
            selectedFile: null,
            imgUrl:  "",
            imgText: "",
            createTime: "",
            oriFileName: ""
        }
    }

    componentDidMount () {

        if (!this.imgQuery){
            const uuid = window.location.hash.replace('#' , '')
            if (uuid.length == 32){
                this.imgQuery = true;
                this.getImgData(uuid)
            }
        }
    }

    onChangeHandler = event =>{
        this.setState({
            selectedFile: event.target.files[0],
            loaded: 0,
        })
    }

    onClickHandler = () => {
        const data = new FormData()

        data.append('file', this.state.selectedFile)
        axios.post(this.host + "/api/image", data, {
            onUploadProgress: ProgressEvent => {
                this.setState({
                    loaded: (ProgressEvent.loaded / ProgressEvent.total*100),
                    })
                },
            })
          .then(res => { // then print response status
            toast.success('upload success')
              this.setState({
                  imgUrl: res.data['url'],
                  imgText: res.data['text'],
                  createTime: res.data['time_created'],
                  oriFileName: res.data['original_file_name']
              })
          })
          .catch(err => { // then print response status
            toast.error('upload fail')
          })
    }

    getImgData = (uuid) => {
        const url = this.host + "/api/get_images/" + uuid
        axios.get(url)
            .then((res) => {
                this.setState({
                  imgUrl: "/uploads/" + res.data['uuid'] + "." + res.data['file_ext'],
                  imgText: res.data['text']
                  createTime: res.data['time_created'],
                  oriFileName: res.data['original_file_name']
            })
            window.iii = res.data
        })
            .catch((err) => {
                toast.error("Can't get the image!")
        })
    }

    render () {
        return (
            <>
                <Container>
                    <br/>
                    <Row className="justify-content-md-center">
                        <Col md="auto">
                            { !this.imgQuery ? (
                                <UploadCard onChangeHandler={this.onChangeHandler} onClickHandler={this.onClickHandler} loaded={this.state.loaded}/>
                            ) : (
                                <div> </div>
                            )}
                        </Col>
                    </Row>
                    <br/>
                    <Row className="justify-content-md-center">
                        <Col md="auto">
                            {this.state.imgUrl ? (
                                <ImgCard imgUrl={this.state.imgUrl} imgText={this.state.imgText}/>
                            ) : (
                                <div></div>
                            )}
                        </Col>
                    </Row>
                </Container>
            </>
        );
    }
}

