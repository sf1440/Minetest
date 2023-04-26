-- Linus block
-- A block that loves and supports you

-- Name and alias
minetest.register_alias("linus", "linus:linus_block")

-- Register the block
minetest.register_node("linus:linus_block", {
    description = "linus",
    -- Set block breakable by hand
    groups = {oddly_breakable_by_hand = 2},
    -- Set block faces to the png texture
    tiles = {"linus.png"},
    -- Set block placeable on ground
    is_ground_content = true,
    -- Set inventory image
    -- Can use other minetest inventory visualization functions instead
    inventory_image = minetest.inventorycube("linus.png", "linus.png", "linus.png"),
})

-- Set crafting recipe
minetest.register_craft({
    -- Crafting yield '{alias} {yield}'
    output = 'linus:linus_block 1',
    -- Crafting recipe is 3x3 grid
    -- Prefix 'default' for vanilla blocks
    recipe = {
        {'default:wood', '', 'default:wood'},
	{'', '', ''},
	{'', '', ''},
    }
})
