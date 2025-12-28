-----------------------------------
-- Area: Everbloom Hollow
--  Mob: Knight Crab (King Arthro add)
-- Notes:
--  - Spawned by King Arthro when using Bubble Shower. Level 70-72, up to 12 may be spawned.
--  - Exclusively casts Water IV on King Arthro to heal it for 517-521 HP
--  - Dies with King Arthro
-- Unverified:
--  - May absorb Water like King Arthro
--  - May run back to King Arthro if kited away to cast Water IV
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    -- TODO: Knight Crab casts Water IV exclusively on King Arthro
    return xi.magic.spell.WATER_IV
end

return entity
