-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Suzaku (Pet version)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

-- Return the selected spell ID.
entity.onMobMagicPrepare = function(mob, target, spellId)
    -- Suzaku uses     Burn, Fire IV, Firaga III, Flare
    -- Let's give -ga3 a higher distribution than the others.
    local rnd = math.random(1, 100)

    if rnd <= 50 then
        return 176 -- firaga 3
    elseif rnd <= 70 then
        return 147 -- fire 4
    elseif rnd <= 90 then
        return 204 -- flare
    else
        return 235 -- burn
    end
end

return entity
