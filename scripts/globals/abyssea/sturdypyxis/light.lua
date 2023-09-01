-----------------------------------
-- Abyssea Sturdy Pyxis - Light
-----------------------------------
require('scripts/globals/abyssea')
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.light = {}

xi.pyxis.light.giveLight = function(npc, player)
    local alliance = player:getAlliance()
    local light  = npc:getLocalVar('LIGHT')
    local lightValue = npc:getLocalVar('LIGHT_VALUE')

    for p, member in ipairs(alliance) do
        if
            member:getZoneID() == player:getZoneID() and
            member:isPC()
        then
            xi.abyssea.addPlayerLights(member, light, lightValue)
        end
    end
end
