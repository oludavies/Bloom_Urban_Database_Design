# Bloom_Urban
 Personal project: Inventory Management System (Database) for a multichain Retail Store (Mall)

## Workflow Overview: Workflow for Inventory Management Database Design:

# Requirement Analysis
    - Identify entities (Products, Branches, Customers, Suppliers, etc.).
    - Define key processes (stock management, sales, restocking, reporting).
    - Gather data about operational needs specific to Nigeria's regions and states.

# Database Design Phases
    - Conceptual Design: Create an Entity-Relationship Diagram (ERD).
    - Logical Design: Normalize data to avoid redundancy.
    - Physical Design: Define database schema, indexes, and keys.

# Implementation
    - Use MSSQL/MySQL to define and create database schema.
    - Implement constraints for referential integrity.
    - Develop necessary stored procedures, triggers, and views.

# Testing and Optimization
    - Test the database for functional requirements and load performance.
    - Optimize queries and indexing.

# Deployment and Maintenance
    - Deploy the database to the server and integrate it with the front-end system.
    - Ensure regular updates and backups.


## Entity-Relationship Diagram (ERD)
|| Relationships:
    Products → Categories: Many-to-One
    Products → Suppliers: Many-to-One
    Transactions → Branches: Many-to-One
    TransactionDetails → Transactions: One-to-Many
    TransactionDetails → Products: Many-to-One
    StockAdjustments → Products: Many-to-One
    StockAdjustments → Branches: Many-to-One


# Supplier Management

    - Maintain a comprehensive database of suppliers
    - Track supplier contact details and payment terms
    - Evaluate supplier performance


# Product Management

    - Create and manage product categories
    - Define product details including pricing, tax rates, and      reorder levels
    - Implement barcode tracking for easy identification


# Inventory Tracking

    - Real-time stock monitoring across all branches
    - Set up automatic reorder alerts
    - Track inventory movements (purchases, sales, transfers)


# Purchasing Process

    - Generate purchase orders based on inventory levels
    - Track order status from creation to delivery
    - Record received quantities and reconcile with initial orders


# Sales Management

    - Record all sales transactions
    - Capture detailed sales information
    - Track sales by branch, employee, and product


# Reporting and Analytics

    || Generate reports on:

        - Stock levels
        - Sales performance
        - Purchasing trends
        - Inventory movements


# Key Design Considerations

    || Multi-Branch Support

        - Each branch is linked to a region
        - Separate inventory tracking for each branch
        - Ability to transfer stock between branches


    || Referential Integrity

        -Foreign key constraints ensure data consistency and enforce relationships between entities.
        - Prevents orphaned records
        - Maintains relationships between entities


    || Audit Trail

        - Inventory_Movements table tracks all stock changes
        - Captures who made the change, when, and why


    || Scalability

        - Optimized for a distributed setup across states and regions.

    || Flexibility

        - Supports multiple product categories
        - Handles different payment methods
        - Allows for future expansion


    || Localization: Accommodates Nigeria's regional and operational diversity.

        - Supports multiple locations across Nigerian states
        - Includes fields for tax identification
        - Supports local payment methods
        - Multilingual support potential (though not implemented in schema)

    || Normalization
    
        - Eliminates redundancy and ensures efficient data updates.

    || Security

        - User roles restrict data access (e.g., Cashiers vs. Admins).


# Detailed Database Design for Inventory Management
    || Entities and Attributes
        
        // Products

        ProductID (Primary Key)
        ProductName
        CategoryID (Foreign Key)
        UnitPrice
        QuantityInStock
        ReorderLevel
        
        // Categories

        CategoryID (Primary Key)
        CategoryName
        
        // Branches

        BranchID (Primary Key)
        BranchName
        State
        Region
    
        // Suppliers

        SupplierID (Primary Key)
        SupplierName
        ContactNumber
        Address
    
        // Transactions

        TransactionID (Primary Key)
        BranchID (Foreign Key)
        TransactionType (SALE or RESTOCK)
        TransactionDate
        TotalAmount
        // TransactionDetails

        TransactionDetailID (Primary Key)
        TransactionID (Foreign Key)
        ProductID (Foreign Key)
        Quantity
        Price
    
        // Users

        UserID (Primary Key)
        Username
        Password
        Role (Admin, Manager, Cashier)
    
        // StockAdjustments

        AdjustmentID (Primary Key)
        BranchID (Foreign Key)
        ProductID (Foreign Key)
        AdjustmentType (ADD, REMOVE)
        AdjustmentQuantity
        AdjustmentDate



# Key Enhancements:

    - Added customer management for loyalty tracking
    - Introduced warehouse tracking
    - Asset management for branch equipment
    - Returns and refunds system
    - Pricing and discount rule management
    - Implemented AUTO_INCREMENT for primary keys
    - Added strategic indexing for performance

# Recommended Additions

    - Implement database indexing for performance
    - Create views for common reporting needs
    - Set up stored procedures for complex operations
    - Implement robust security and access control

    - Use UUID or more complex auto-generation for sensitive identifiers
    - Implement database triggers for complex business logic
    - Consider data archiving strategies for historical records