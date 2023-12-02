provider "aws"{

      region="us-east-2c"
      access_key="AKIA6JTNUSPCEPSLBF7E"
      secret_key="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"

}

resource "aws_instance" "Node.js App" {

      ami= "ami-06d4b7182ac3480fa"
      instance_type="t2.micro"

       tags={
       Name="webserver"
       server="prod"

}

}



###create vpc###

resource "aws_vpc" "test-vpc" {

        cidr_block = "10.10.0.0/16"
        tags = {
                Name = "test-vpc"
        }
}

#####creating subnets######

resource "aws_subnet" "subnet-1" {
        vpc_id = "${aws_vpc.test-vpc.id}"
        cidr_block = "10.10.1.0/24"
        availability_zone = "ap-south-1a"
        tags = {
                Name = "subnet-1"
        }
}

resource "aws_subnet" "subnet-2" {
        vpc_id = "${aws_vpc.test-vpc.id}"
        cidr_block = "10.10.2.0/24"
        availability_zone = "ap-south-1b"
        tags = {
                Name = "subnet-2"
        }
}

######### creating internet igw#######

resource "aws_internet_gateway" "test-vpc-igw" {

        vpc_id = "${aws_vpc.test-vpc.id}"
        tags = {
                Name = "test-vpc-igw"
        }
}

###############################public-rt-creation#####

resource "aws_route_table" "public-rt" {
        vpc_id = "${aws_vpc.test-vpc.id}"

        route {
                cidr_block = "0.0.0.0/0"
                gateway_id = "${aws_internet_gateway.test-vpc-igw.id}"
        }
}
####association of subents####

resource "aws_route_table_association" "public-routing-1" {

        subnet_id = "${aws_subnet.subnet-1.id}"
        route_table_id = "${aws_route_table.public-rt.id}"
}


resource "aws_route_table_association" "public-routing-2" {

        subnet_id = "${aws_subnet.subnet-2.id}"
        route_table_id = "${aws_route_table.public-rt.id}"
}

