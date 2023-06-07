-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Ubume
-- Involved in Quest: Yomi Okuri
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local delay = mob:getLocalVar("delay")
    if os.time() > delay then -- Use Horde Lullaby every 40s
        mob:castSpell(xi.magic.spell.HORDE_LULLABY, target)
        mob:setLocalVar("delay", os.time() + 40)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
