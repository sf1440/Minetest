-- minetest.register_node(":simple", {
--     description = "simple mod",
--     groups = {oddly_breakable_by_hand=2},
--     tiles = {"default_wood.png"},
-- })

-- minetest.register_craft({
--     output = 'simple',
--     recipe = {
--         {"default:wood", "default:wood"},
--     },
-- })

function register_wasm_mod(name, description, texture, material)
    minetest.register_node(":" .. name, {
        description = description,
        groups = {oddly_breakable_by_hand=2},
        tiles = {texture},
    })

    minetest.register_craft({
        output = name,
        recipe = {
            {material, '', ''},
            {material, '', ''},
            {material, material, ''},
        },
    })
end
