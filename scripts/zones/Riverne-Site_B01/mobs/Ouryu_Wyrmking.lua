-----------------------------------
-- Area: Riverne Site B01
-- Note: Weaker version of Ouryu summoned by Bahamut during The Wyrmking Descends
-----------------------------------
---    require('scripts/mixins/families/flying_wyrm'),
mixins =
{
    require('scripts/mixins/job_special')
}
-----------------------------------
---@type TMobEntity
local entity = {}

local offsets = { 4, 5, 6, 7 }
-- ['Ouryu_Wyrmking'] = { 731, xi.mobSkill.TOUCHDOWN_OURYU, --60, x --2500, --true  }, -- BCNM: The Wyrmking Descends.
-- 60 sec ground phase, 30 sec fly phase, 2500 damage force phase change
-- Ouryu PLD/PLD NM lvl 90, WKD lvl 88 (multiply values by 0.98)

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addMod(xi.mod.BLINDRES, 25)
    mob:addMod(xi.mod.PARALYZERES, 25)
end

entity.onMobSpawn = function(mob)
    mob:setSpellList(548)

    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 52)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)

    mob:setMod(xi.mod.UFASTCAST, 75)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.REFRESH, 200)

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING))
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.INVINCIBLE, hpp = math.random(50, 80) },
        },
    })
end

entity.onMobFight = function(mob, target)
    local delay = mob:getLocalVar('delay')
    -- summon Ziryu every 90s
    if delay > 90 then
        mob:setLocalVar('delay', 0)

        local mobId = mob:getID()
        for i, offset in ipairs(offsets) do
            local pet = GetMobByID(mobId + offset)

            if pet and not pet:isSpawned() then
                    pet:spawn()
                    local pos = mob:getPos()
                    pet:setPos(pos.x + math.random(2, 6), pos.y, pos.z + math.random(2, 6))
                    local mobTarget = mob:getTarget()
                    if mobTarget then
                        pet:updateEnmity(mobTarget)
                    end
                break
            end
        end
    else
        mob:setLocalVar('delay', delay + 1)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Needs to gain TP from flight auto attacks
    if skill:getID() == 1298 then
        mob:addTP(65)
    end
end

-- adds do not die when ouryu dies
entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENSTONE, { damage = math.random(89, 111), chance = 10 })
end

return entity
