---------------------------------------------------------
-- Trust
---------------------------------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------------------

tpz = tpz or {}
tpz.trust = tpz.trust or {}

tpz.trust.canCast = function(caster, spell, not_allowed_trust_ids)

    -- TODO: Each of these scenarios has its own message

    -- Trusts not allowed in an alliance
    if caster:checkSoloPartyAlliance() == 2 then
        return tpz.msg.basic.TRUST_NO_CAST_TRUST
    end

    -- Trusts only allowed in certain zones
    if not caster:canUseMisc(tpz.zoneMisc.TRUST) then
        -- TODO: Update area flags
        --return tpz.msg.basic.TRUST_NO_CALL_AE
    end

    -- You can only summon trusts if you are the party leader or solo
    local leader = caster:getPartyLeader()
    if leader and caster:getID() ~= leader:getID() then
          return tpz.msg.basic.TRUST_NO_CAST_TRUST
    end

    -- TODO: Block summoning trusts if someone recently joined party

    -- Trusts cannot be summoned if you have hate
    if caster:hasEnmity() then
        return tpz.msg.basic.TRUST_NO_CAST_TRUST
    end

    -- Check party for trusts
    local num_pt = 0
    local num_trusts = 0
    local party = caster:getPartyWithTrusts()
    for _, member in ipairs(party) do
        if member:getObjType() == tpz.objType.TRUST then
            -- Check for same trust
            if member:getTrustID() == spell:getID() then
                return tpz.msg.basic.TRUST_NO_CAST_TRUST
            -- Check not allowed trust combinations (Shantotto I vs Shantotto II)
            elseif type(not_allowed_trust_ids) == "number" then
                if member:getTrustID() == not_allowed_trust_ids then
                    return tpz.msg.basic.TRUST_NO_CAST_TRUST
                end
            elseif type(not_allowed_trust_ids) == "table" then
                for _, v in pairs(not_allowed_trust_ids) do
                    if type(v) == "number" then
                        if member:getTrustID() == v then
                            return tpz.msg.basic.TRUST_NO_CAST_TRUST
                        end
                    end
                end
            end
            num_trusts = num_trusts + 1
        end
        num_pt = num_pt + 1
    end

    -- Max party size
    if num_pt >= 6 then
        return tpz.msg.basic.TRUST_NO_CAST_TRUST
    end

    -- Limits set by ROV Key Items
    if num_trusts >= 3 and not caster:hasKeyItem(tpz.ki.RHAPSODY_IN_WHITE) then
        return tpz.msg.basic.TRUST_NO_CAST_TRUST
    elseif num_trusts >= 4 and not caster:hasKeyItem(tpz.ki.RHAPSODY_IN_CRIMSON) then
        return tpz.msg.basic.TRUST_NO_CAST_TRUST
    end

    return 0
end

tpz.trust.spawn = function(caster, spell)
    caster:spawnTrust(spell:getID())

    return 0
end
