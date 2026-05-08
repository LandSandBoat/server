-----------------------------------
-- ID: 15533
-- Item: Chocobo Whistle
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if not target:canUseMisc(xi.zoneMisc.MOUNT) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    elseif
        target:getMainLvl() < 20 or -- TODO: setting?
        not target:hasKeyItem(xi.ki.CHOCOBO_LICENSE) or -- TODO: Is this true?
        target:hasEnmity()
    then
        return xi.msg.basic.ITEM_UNABLE_TO_USE -- TODO: Verify/correct message, order of message priority.
    end

    -- TODO: Make a new binding for this that only gives back the actual m_FieldChocobo registered information
    local info = target:getChocoboRaisingInfo()
    if info == nil then
        return xi.msg.basic.ITEM_UNABLE_TO_USE -- TODO: Verify/correct message
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    -- TODO:
    -- Base duration 30 min, in seconds.
    local duration = 1800 + (target:getMod(xi.mod.CHOCOBO_RIDING_TIME) * 60)

    -- NOTE: Chocobo look is handled in core by virtue of if PChar->m_FieldChocobo being populated
    target:addStatusEffect(xi.effect.MOUNTED, { power = xi.mount.CHOCOBO, duration = duration, origin = user, subPower = 64, silent = true })
end

return itemObject
