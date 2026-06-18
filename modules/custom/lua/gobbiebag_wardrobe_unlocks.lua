-----------------------------------
-- Unlock Mog Wardrobe slots with Gobbiebag quests
-- Find a way to move gobbiebag wardrobe quests into this module
-----------------------------------
require('modules/module_utils')
require('scripts/globals/player')
-----------------------------------
local m = Module:new('wardrobe_gobbiebags')

-- Override character creation to lock wardrobes 4-8
m:addOverride('xi.player.charCreate', function(player)
    super(player)

    -- Lock wardrobes 4-8 at creation as they will be unlocked via quests
    -- Wardrobes 1-3 will remain available from character creation
    player:changeContainerSize(xi.inv.WARDROBE4, -80)
    player:changeContainerSize(xi.inv.WARDROBE5, -80)
    player:changeContainerSize(xi.inv.WARDROBE6, -80)
    player:changeContainerSize(xi.inv.WARDROBE7, -80)
    player:changeContainerSize(xi.inv.WARDROBE8, -80)
end)

return m
