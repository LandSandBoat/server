-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Ariri Samariri (Einherjar)
-- Notes: Immune to Gravity, Bind, and Silence.
-- Water Bomb randomly resets hate.
-- Ariri runs back to its spawn at increased speed when all reset.
-- Has increased regain below 25% (+200)
-- Unverified/unimplemented claims:
--  - The position it runs to may be random and not its spawn
--  - Resistance to damage increases as HP decreases.
--  - Black Mage spells appear to do half damage.
-----------------------------------
mixins =
{
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

local function reset(mob)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 0)
    mob:setMobMod(xi.mobMod.RUN_SPEED_MULT, 100)
    mob:setMagicCastingEnabled(true)
end

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    -- Reset Ariri to the right spell list after Providence
    mob:setLocalVar('spellListId', 540)
end

entity.onMobEngage = reset

entity.onMobFight = function(mob)
    if mob:getHPP() <= 25 then
        mob:setMod(xi.mod.REGAIN, 200)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if
        skill:getID() == xi.mobSkill.WATER_BOMB and
        math.random(1, 100) <= 25
    then
        local enmityList = mob:getEnmityList()
        for _, enmity in ipairs(enmityList) do
            mob:clearEnmityForEntity(enmity.entity)
        end

        mob:disengage()

        -- Passive for 20 seconds with increased run speed
        mob:setMobMod(xi.mobMod.RUN_SPEED_MULT, 200)
        mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
        mob:setMagicCastingEnabled(false)
        mob:timer(20000, reset)
    end
end

return entity
