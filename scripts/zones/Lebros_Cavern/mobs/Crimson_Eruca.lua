-----------------------------------
-- Area: Lebros Cavern
--  MOB: Crimson Eruca
-----------------------------------
-----------------------------------

local entityObject = {}

entityObject.onMobSpawn = function(mob)
    mob:setTrueDetection(true)
end

entityObject.onMagicHit = function(caster, target, spell)
    local gravity   = 216
    local sleep     = 253
    local bind      = 258
    local sleepII   = 259
    local sleepga   = 273
    local sleepgaII = 274

    if spell:tookEffect() then
        local spellID = spell:getID()
        if spellID == sleep or sleepII or sleepga or sleepgaII then
            target:addMod(xi.mod.SLEEPRES, 50)
        elseif spellID == bind then
            target:addMod(xi.mod.BINDRES, 50)
        elseif spellID == gravity then
            target:addMod(xi.mod.GRAVITYRES, 50)
        end
    end
end

entityObject.onMobDeath = function(mob, player, isKiller)
end

return entityObject
