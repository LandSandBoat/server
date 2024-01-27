-----------------------------------
-- Area: La Theine Plateau
--  NPC: FallenEgg
-- Spawns NM Nihniknoovi
-----------------------------------
local laTheineGlobal = require('scripts/zones/La_Theine_Plateau/globals')
local ID = zones[xi.zone.LA_THEINE_PLATEAU]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local random = math.random(1, 100)
    local nm = GetMobByID(ID.mob.NIHNIKNOOVI)
    if random <= 20 and not nm:isSpawned() then
        local x = npc:getXPos()
        local y = npc:getYPos()
        local z = npc:getZPos()
        nm:setSpawn(x, y, z)
        SpawnMob(ID.mob.NIHNIKNOOVI):updateClaim(player)
        laTheineGlobal.moveFallenEgg(1800)
    elseif random > 20 and random <= 61 then
        player:messageSpecial(ID.text.BROKEN_EGG)
        laTheineGlobal.moveFallenEgg(300)
    elseif random > 61 then
        npcUtil.giveItem(player, xi.item.BIRD_EGG)         -- bird egg
        laTheineGlobal.moveFallenEgg(300)   -- moved whether the item is obtained or not, to counter abuse with a full inv
    end
end

return entity
