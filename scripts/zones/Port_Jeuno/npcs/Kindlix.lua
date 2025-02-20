-----------------------------------
-- Area: Port Jeuno
--  NPC: Kindlix
-- !pos -18.820 4.000 23.302 246
-----------------------------------
local ID = zones[xi.zone.PORT_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

local stock =
{
    4250,   22,    -- Crackler
    4167,   25,    -- Cracker
    4168,   25,    -- Twinkle Shower
    4169,   25,    -- Little Comet
    4217,   25,    -- Sparkling Hand
    4215,   50,    -- Popstar
    4216,   50,    -- Brilliant Snow
    5769,   50,    -- Popper
    4186,  100,    -- Airborne
    4218,  100,    -- Air Rider
    5937,  150,    -- Bubble Breeze
    5883,  200,    -- Falling Star
    5882,  250,    -- Marine Bliss
    4257,  300,    -- Papillion
    5441,  300,    -- Angelwing
    5936,  300,    -- Mog Missile
}

entity.onTrigger = function(player, npc)
    if  player:getCharVar('spokeKindlix') == 1 then
        player:startEvent(348)
    else
        player:showText(npc, ID.text.KINDLIX_SHOP_DIALOG)
        xi.shop.general(player, stock)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 348 and option == 0 then
        xi.shop.general(player, stock)
        player:setCharVar('spokeKindlix', 0)
    end
end

return entity
