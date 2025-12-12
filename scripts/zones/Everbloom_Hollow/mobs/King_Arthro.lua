-----------------------------------
-- Area: Everbloom Hollow
--  Mob: King Arthro (Sandworm)
-- Notes:
--  - Absorbs Water damage. Knight Crabs cast Water IV to heal it for 517-521 HP.
--  - All incoming damage capped to 1 except:
--    - Critical Hits (does not uncap associated additional effect)
--    - Magic Bursts
--    - Water heals
--    - Skillchains from critical WS
--  - Spawns Knight Crabs level 70-72 (up to 12) after using Bubble Shower
--  - Knight Crabs die with King Arthro
-- Unverified:
--  - Rate for spawning Knight Crabs may be tied to HPP
--  - Has some unquantified PDT beyond the 1 damage cap mechanic
--  - Effect of the damage cap on DoTs
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:setMod(xi.mod.WATER_ABSORB, 100)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.ENWATER,
        xi.magic.spell.DROWN,
        xi.magic.spell.WATERGA_IV,
        xi.magic.spell.POISONGA_II,
    }

    return spellList[math.random(1, #spellList)]
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- TODO: Spawns a Knight Crab (up to 12) on Bubble Shower
end

entity.onMobDeath = function(mob, player, optParams)
    -- TODO: Kill all Knight Crabs
end

return entity
