## criação do banco de dados para o cenário de E-commerce
create database if not exists ecommerce;
use ecommerce;

## criar tabela cliente
	create table if not exists clients(
		idClient int unsigned auto_increment primary key, 
		Fname varchar(20),
		Mname varchar(20),
		Lname varchar(20),
		CPF char(11) not null,
		Address varchar(50),
		constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment = 1;
## criar tabela produto
	create table if not exists products(
		idProduct int unsigned auto_increment primary key,
        Pname varchar(40) not null,
        classification_kids bool default false,
        category enum('Eletrônico', 'Vestimenta', 'Brinquedo', 'Alimentos', 'Móveis') not null,
        avaliation float default 0,
        size varchar(10)
	);
## criar tabela pedido
	create table if not exists orders(
		idOrder int unsigned auto_increment primary key,
        idOrderClient int unsigned,
        orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
        ordersDescription varchar(255),
        sendValue float default 10,
        idPayment int unsigned,
        paymentCash bool default false,
        constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
			on update cascade
    );
## criar tabela pagamento
	create table if not exists payments(
		idclient int unsigned,
        id_payment int unsigned,
        typePayment enum('Boleto', 'Cartão', 'Dois Cartões'),
        limitAvailable float,
        primary key(idClient, id_payment),
        constraint fk_payment_client foreign key (idclient) references clients(idClient)
    );
    
## criar tabela estoque
	create table if not exists productStorage(
		idProdStorage int unsigned auto_increment primary key,
        storageLocation varchar(255),
        quantity int default 0
    );
    
## criar tabela fornecedor
	create table if not exists supplier(
		idSupplier int unsigned auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char(15) not null,
        contact varchar(11) not null,
        constraint unique_Supplier unique (CNPJ)
    );
    
## criar tabela vendedor
	create table if not exists seller(
		idSeller int unsigned auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15),
        CPF char(9),
        location varchar(10),
        contact char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique(CPF)
    );
    
	create table if not exists productSeller(
		idPseller int unsigned,
        idProduct int unsigned,
        prodQuantity int default 1,
        primary key(idPseller, idProduct),
        constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
        constraint fk_product_product foreign key (idProduct) references products(idProduct)
	);
    
    create table if not exists productOrder(
		idPOproduct int unsigned,
        idPOorder int unsigned,
        poQuantity int default 1,
        poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
        primary key(idPOproduct, idPOorder),
        constraint fk_productOrder_seller foreign key (idPOproduct) references products(idProduct),
        constraint fk_product_order foreign key (idPOorder) references orders(idOrder)
    );
    
    create table if not exists storageLocation(
		idLproduct int unsigned,
        idLstorage int unsigned,
        location varchar(255) not null,
        primary key (idLproduct, idLstorage),
        constraint fk_storagelock_product foreign key (idLproduct) references products(idProduct),
        constraint fk_product_storage foreign key (idLstorage) references productStorage(idProdStorage)
    );
    
## Inserindo dados
	insert into clients (Fname, Mname, Lname, CPF, Address)
		   values('Maria', 'M', 'Silva', '123456789', 'Rua A'),
                 ('José', 'M', 'Silva', '987654321', 'Rua B'),
                 ('Joana', 'S', 'Sonio', '543216789', 'Rua C');
	
    insert into products (Pname, category, avaliation, size)
		   values('Laranja', 'Alimentos', 5, '1un'),
                 ('Café', 'Alimentos', 5, '800g'),
                 ('Pão', 'Alimentos', 5, '200g');
                 
	insert into orders (idOrderClient, orderStatus, ordersDescription, sendValue, idPayment, paymentCash)
		   values(1, 'Confirmado', '  ', 55.00, 1, true),
                 (2, 'Confirmado', '  ', 300.00, 2, false),
                 (3, 'Confirmado', '  ', 189.89, 1, true);
                 
## Buscando dados
	Select * from clients;
    Select * from products;
    Select * from orders;
    Select * from clients c, orders o where idOrderClient = dClient;
    
