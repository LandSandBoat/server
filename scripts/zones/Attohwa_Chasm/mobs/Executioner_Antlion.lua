-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Executioner Antlion
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
mixins = { require('scripts/mixins/families/antlion_ambush_no_rehide') }
local attohwaChasmGlobal = require('scripts/zones/Attohwa_Chasm/globals')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)

    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobDespawn = function(mob)
    local feelerAntlionQM = GetNPCByID(ID.npc.QM_FEELER_ANTLION)
    if
        feelerAntlionQM and
        attohwaChasmGlobal.canStartFeelerQMTimer()
    then
        feelerAntlionQM:updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
