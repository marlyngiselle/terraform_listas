provider "aws" {}

variable redes {
  type        = list(any)
  default     = ["10.0.0.0/16" , "172.16.0.0/16" , "192.168.0.0/16"]
  description = "Todas mis redes"
}

resource "aws_vpc" "redes" {
  count = 3
  cidr_block = var.redes[count.index]
  tags = { Name = "red-${count.index + 1}" }
}

resource "aws_subnet" "sr1" {
  count = 5
  vpc_id = aws_vpc.redes[0].id
  cidr_block = "10.0.${count.index}.0/24"
  tags = { Name = "red-1-subred-${count.index + 1}" }
}

resource "aws_subnet" "sr2" {
  count = 5
  vpc_id = aws_vpc.redes[1].id
  cidr_block = "172.16.${count.index}.0/24"
  tags = { Name = "red-2-subred-${count.index + 1}" }
}

resource "aws_subnet" "sr3" {
  count = 5
  vpc_id = aws_vpc.redes[2].id
  cidr_block = "192.168.${count.index}.0/24"
  tags = { Name = "red-3-subred-${count.index + 1}" }
}



