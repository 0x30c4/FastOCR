import React, { useState } from 'react';
import {
        Button, Card, CardBody, CardText,
        CardImg, CardTitle, CardHeader, CardFooter
} from 'reactstrap';
import { CopyToClipboard } from "react-copy-to-clipboard";


const onCopyText = () => {
};

const openInNewTab = (url) => {
    url = window.location.protocol + "//" + window.location.host + url.split('uploads/')[1].split('.')[0]
    const newWindow = window.open(url, '_blank', 'noopener,noreferrer')
    if (newWindow) newWindow.opener = null
}


export default function ImgCard ({ imgText, imgUrl }) {
    const [text, setText] = useState("");
    const [isCopied, setIsCopied] = useState(false);
    return (
        <Card >
          <CardBody>
            <CardHeader>
                <h2>
                    Image Text
                </h2>
            </CardHeader>
            <hr/>
            &nbsp;&nbsp;&nbsp;
            <Button className='mx-2' onClick={() => openInNewTab(imgUrl)}>
                Open In an New Tab
            </Button>
            <CopyToClipboard text={imgText} onCopy={onCopyText}>
                <Button>Copy Text To Clipboard</Button>
            </CopyToClipboard>
            <hr/>
            <CardText>
                {imgText}
            </CardText>
          </CardBody>
          <CardImg variant="bottom" src={imgUrl}/>
          <CardFooter>
                Hello
          </CardFooter>
        </Card>
    );
}
