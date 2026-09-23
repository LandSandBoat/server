/************************************************************************
 * Account Variables Module
 *
 * This module extends CLuaBaseEntity with account-wide variable methods
 * similar to how char_vars work but at the account level instead of character level.
 *
 * Methods provided:
 * - player:getAccountVar(varname) - Get an account variable value
 * - player:setAccountVar(varname, value, expiry) - Set an account variable (value 0 = delete)
 ************************************************************************/

#include "account_vars.h"

#include "common/database.h"
#include "common/logging.h"
#include "common/vana_time.h"
#include "map/entities/char_entity.h"
#include "map/lua/luautils.h"
#include "map/utils/moduleutils.h"

namespace accountvars
{

auto fetchAccountVar(const uint32 accountId, const std::string& varname) -> int32
{
    const auto rset = db::preparedStmt("SELECT value, expiry FROM account_vars WHERE accountid = ? AND varname = ? LIMIT 1", accountId, varname);

    if (!rset || !rset->rowsCount() || !rset->next())
    {
        return 0;
    }

    const auto expiry = rset->get<uint32>("expiry");

    // An expired variable reads as absent and is removed on the way out
    if (expiry > 0 && expiry <= earth_time::timestamp())
    {
        db::preparedStmt("DELETE FROM account_vars WHERE accountid = ? AND varname = ?", accountId, varname);
        return 0;
    }

    return rset->get<int32>("value");
}

// A value of zero deletes the variable
void persistAccountVar(const uint32 accountId, const std::string& varname, const int32 value, const uint32 expiry)
{
    if (expiry > 0 && expiry <= earth_time::timestamp())
    {
        ShowWarningFmt("Attempting to set account variable '{}' with an expired time: {}", varname, expiry);
        return;
    }

    if (value == 0)
    {
        db::preparedStmt("DELETE FROM account_vars WHERE accountid = ? AND varname = ? LIMIT 1", accountId, varname);
        return;
    }

    db::preparedStmt("INSERT INTO account_vars SET accountid = ?, varname = ?, value = ?, expiry = ? "
                     "ON DUPLICATE KEY UPDATE value = ?, expiry = ?",
                     accountId,
                     varname,
                     value,
                     expiry,
                     value,
                     expiry);
}

} // namespace accountvars

class AccountVarsModule : public CPPModule
{
    void OnInit() override
    {
        TracyZoneScoped;

        // Startup cleanup of expired account variables
        uint32 currentTimestamp = earth_time::timestamp();
        db::preparedStmt("DELETE FROM account_vars WHERE expiry > 0 AND expiry <= ?", currentTimestamp);

        // Extend CLuaBaseEntity with account variable methods
        sol::usertype<CLuaBaseEntity> baseEntityType = ::lua["CBaseEntity"];

        baseEntityType["getAccountVar"] = [](CLuaBaseEntity* PLuaBaseEntity, const std::string& varname) -> int32
        {
            if (auto PChar = dynamic_cast<CCharEntity*>(PLuaBaseEntity->GetBaseEntity()))
            {
                return accountvars::fetchAccountVar(PChar->accid, varname);
            }

            return 0;
        };

        // Register setAccountVar method: player:setAccountVar(varname, value, expiry)
        // Notes: Passing a '0' value will delete the variable
        baseEntityType["setAccountVar"] = [](CLuaBaseEntity* PLuaBaseEntity, const std::string& varname, int32 value, const sol::object& expiry) -> void
        {
            if (auto PChar = dynamic_cast<CCharEntity*>(PLuaBaseEntity->GetBaseEntity()))
            {
                uint32 expiryValue = 0;

                if (expiry.is<uint32>())
                {
                    expiryValue = expiry.as<uint32>();
                }

                accountvars::persistAccountVar(PChar->accid, varname, value, expiryValue);
            }
        };
    }
};

REGISTER_CPP_MODULE(AccountVarsModule);
