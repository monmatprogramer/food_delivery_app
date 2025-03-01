SELECT * FROM food_delivery_db.restaurant;
SELECT * FROM food_delivery_db.category ;
-- Create many to many
-- CREATE TABLE `food_delivery_db`.`restaurant_category` (
--   `restaurant_id` INT NOT NULL,
--   `category_id` INT NOT NULL,
--   PRIMARY KEY (`restaurant_id`, `category_id`),
--   CONSTRAINT `restaurant_id`
--     FOREIGN KEY (`restaurant_id`)
--     REFERENCES `food_delivery_db`.`restaurant` (`id`)
--     ON DELETE NO ACTION
--     ON UPDATE NO ACTION,
--   CONSTRAINT `category_id`
--     FOREIGN KEY (`category_id`)
--     REFERENCES `food_delivery_db`.`category` (`id`)
--     ON DELETE CASCADE
--     ON UPDATE CASCADE);

INSERT INTO food_delivery_db.restaurant (name, imageUrl, rating, deliveryTime, isFeatured) 
VALUES ('Italiano Delight', 'https://example.com/images/italiano.jpg', 4.7, '2025-02-28 12:30:00', TRUE);

INSERT INTO food_delivery_db.category (name, icon) 
VALUES ('Italian', 'pasta_icon');