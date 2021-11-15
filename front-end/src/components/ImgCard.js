import React from 'react';
import {
        Button, Card, CardBody, CardText,
        CardImg, CardTitle, CardHeader, CardFooter
} from 'reactstrap';


export default function ImgCard ({ imgText, imgUrl }) {
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
            <Button className='mx-2'>
                Open In an New Tab
            </Button>
            <Button>
                Copy Text
            </Button>
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
