-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel TT
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.UFASTCAST, 30)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        between = 30,
        specials =
        {
            { id = xi.jsa.BLOOD_WEAPON },
            {
                id = xi.jsa.MANAFONT,
                endCode = function(mobArg) -- "Uses Manafont and ... Will cast Sleepga followed by Meteor."
                    mobArg:castSpell(273) -- sleepga
                    mobArg:castSpell(218) -- meteor
                end,
            },
        },
    })
end

entity.onMobEngaged = function(mob, target)
    local mobid = mob:getID()

    for member = mobid-5, mobid + 2 do
        local m = GetMobByID(member)
        if m:getCurrentAction() == xi.act.ROAMING then
            m:updateEnmity(target)
        end
    end
end

entity.onMobFight = function(mob, target)
    if
        mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and
        bit.band(mob:getBehaviour(), xi.behavior.STANDBACK) > 0
    then
        mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.STANDBACK)))
        mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 0)
        mob:setMobMod(xi.mobMod.SPAWN_LEASH, 0)
        mob:setSpellList(0)
    end

    if
        not mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and
        bit.band(mob:getBehaviour(), xi.behavior.STANDBACK) == 0
    then
        mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
        mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 1)
        mob:setMobMod(xi.mobMod.SPAWN_LEASH, 22)
        mob:setSpellList(39)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
