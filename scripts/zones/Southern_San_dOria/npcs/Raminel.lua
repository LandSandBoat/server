-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Raminel
-- Involved in Quests: Riding on the Clouds
-- !pos -56 2 -21 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -138.436340, y = -2.000000, z = 16.227097 },
    { x = -137.395432, y = -2.000000, z = 15.831898 },
    { x = -136.317108, y = -2.000000, z = 15.728185 },
    { x = -134.824036, y = -2.000000, z = 15.816396 },
    { x = -108.897049, y = -2.000000, z = 16.508110 },
    { x = -107.823288, y = -2.000000, z = 16.354126 },
    { x = -106.804962, y = -2.000000, z = 15.973084 },
    { x = -105.844963, y = -2.000000, z = 15.462379 },
    { x = -104.922585, y = -2.000000, z = 14.885456 },
    { x = -104.020050, y = -2.000000, z = 14.277813 },
    { x = -103.138374, y = -2.000000, z = 13.640303 },
    { x = -101.501289, y = -2.000000, z = 12.422975 },
    { x = -77.636841, y = 2.000000, z = -5.771687 },
    { x = -59.468536, y = 2.000000, z = -19.632719 },
    { x = -58.541172, y = 2.000000, z = -20.197826 },
    { x = -57.519985, y = 2.000000, z = -20.570829 },
    { x = -56.474659, y = 2.000000, z = -20.872238 },
    { x = -55.417450, y = 2.000000, z = -21.129019 },
    { x = -54.351425, y = 2.000000, z = -21.365578 },
    { x = -53.286743, y = 2.000000, z = -21.589529 },
    { x = -23.770412, y = 2.000000, z = -27.508755 },
    { x = -13.354427, y = 1.700000, z = -29.593290, rotation = 13, wait = 4000 }, -- auction house
    { x = -43.848141, y = 2.000000, z = -23.492155 },
    { x = -56.516224, y = 2.000000, z = -20.955723 },
    { x = -57.555450, y = 2.000000, z = -20.638817 },
    { x = -58.514832, y = 2.000000, z = -20.127840 },
    { x = -59.426712, y = 2.000000, z = -19.534536 },
    { x = -60.322998, y = 2.000000, z = -18.917839 },
    { x = -61.203823, y = 2.000000, z = -18.279247 },
    { x = -62.510002, y = 2.000000, z = -17.300892 },
    { x = -86.411278, y = 2.000000, z = 0.921999 },
    { x = -105.625214, y = -2.000000, z = 15.580724 },
    { x = -106.582047, y = -2.000000, z = 16.089426 },
    { x = -107.647263, y = -2.000000, z = 16.304668 },
    { x = -108.732132, y = -2.000000, z = 16.383970 },
    { x = -109.819397, y = -2.000000, z = 16.423687 },
    { x = -110.907364, y = -2.000000, z = 16.429226 },
    { x = -111.995232, y = -2.000000, z = 16.411282 },
    { x = -140.205811, y = -2.000000, z = 15.668728, rotation = 97, wait = 4000 },  -- package Lusiane
    { x = -139.296539, y = -2.000000, z = 16.786556 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onPath = function(npc)
    if
        npc:getLocalVar('delivered') ~= 1 and
        npc:atPoint(xi.path.get(pathNodes, 39))
    then
        -- give package to Lusiane, wait 4 seconds, then continue
        local lus = GetNPCByID(ID.npc.LUSIANE)
        if lus then
            lus:showText(npc, ID.text.RAMINEL_DELIVERY)
            npc:showText(lus, ID.text.LUSIANE_THANK)
        end

        npc:setLocalVar('delivered', 1)
    elseif npc:atPoint(xi.path.last(pathNodes)) then
        -- when I walk away stop looking at me
        GetNPCByID(ID.npc.LUSIANE):clearTargID()
        npc:setLocalVar('delivered', 0)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(614)
end

return entity
