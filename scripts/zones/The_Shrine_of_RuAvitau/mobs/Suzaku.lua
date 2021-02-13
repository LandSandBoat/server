-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Suzaku (Pet version)
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

-- Return the selected spell ID.
entity.onMonsterMagicPrepare = function(mob, target)
    -- Suzaku uses     Burn, Fire IV, Firaga III, Flare
    -- Let's give -ga3 a higher distribution than the others.
    rnd = math.random()

    if (rnd < 0.5) then
        return 176 -- firaga 3
    elseif (rnd < 0.7) then
        return 147 -- fire 4
    elseif (rnd < 0.9) then
        return 204 -- flare
    else
        return 235 -- burn
    end

end

return entity
