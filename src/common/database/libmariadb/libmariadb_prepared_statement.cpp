/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include <common/database/libmariadb/libmariadb_prepared_statement.h>

#include <cstring>
#include <memory>
#include <string>
#include <type_traits>
#include <utility>
#include <variant>
#include <vector>

namespace
{

// Initial per-column fetch buffer for text columns. Larger values (blobs, long strings) are pulled
// in full with a follow-up mysql_stmt_fetch_column once the real length is known.
constexpr unsigned long kInitialColumnBuffer = 256;

} // namespace

db::detail::libmariadb::Error::Error(unsigned int errnum, const std::string& message)
: std::runtime_error(message)
, errnum(errnum)
{
}

auto db::detail::libmariadb::isConnectionLost(unsigned int errnum) -> bool
{
    switch (errnum)
    {
        case 2002: // CR_CONNECTION_ERROR
        case 2003: // CR_CONN_HOST_ERROR
        case 2006: // CR_SERVER_GONE_ERROR
        case 2013: // CR_SERVER_LOST
        case 2055: // CR_SERVER_LOST_EXTENDED
            return true;
        default:
            return false;
    }
}

db::LibMariaDBPreparedStatement::LibMariaDBPreparedStatement(MYSQL_STMT* stmt)
: stmt_(stmt)
{
}

db::LibMariaDBPreparedStatement::~LibMariaDBPreparedStatement()
{
    if (stmt_ != nullptr)
    {
        mysql_stmt_close(stmt_);
    }
}

auto db::LibMariaDBPreparedStatement::bind(int index, const BoundValue& value) -> void
{
    if (static_cast<int>(paramBinds_.size()) < index)
    {
        paramBinds_.resize(index);
    }

    MYSQL_BIND& b = paramBinds_[index - 1];
    std::memset(&b, 0, sizeof(b));

    std::visit(
        [&](const auto& v)
        {
            using U = std::remove_cvref_t<decltype(v)>;
            if constexpr (std::is_same_v<U, std::shared_ptr<BlobWrapper>>)
            {
                auto& buffer = paramBuffers_.emplace_back(v->data.get(), v->data.get() + v->size);
                // Guarantee a non-null data() pointer: libmariadb binds a null buffer as SQL NULL,
                // so an empty blob must still point at valid (zero-length) storage to bind as ''.
                buffer.reserve(1);
                auto& length    = paramLengths_.emplace_back(static_cast<unsigned long>(v->size));
                b.buffer_type   = MYSQL_TYPE_BLOB;
                b.buffer        = buffer.data();
                b.buffer_length = static_cast<unsigned long>(buffer.size());
                b.length        = &length;
            }
            else if constexpr (std::is_same_v<U, std::string>)
            {
                auto& buffer = paramBuffers_.emplace_back(v.begin(), v.end());
                // See above: an empty string must bind as '' (non-null buffer), not SQL NULL.
                buffer.reserve(1);
                auto& length    = paramLengths_.emplace_back(static_cast<unsigned long>(v.size()));
                b.buffer_type   = MYSQL_TYPE_STRING;
                b.buffer        = buffer.data();
                b.buffer_length = static_cast<unsigned long>(buffer.size());
                b.length        = &length;
            }
            else
            {
                // Arithmetic and bool: copy the value bytes into stable storage.
                auto& buffer = paramBuffers_.emplace_back(sizeof(U));
                std::memcpy(buffer.data(), &v, sizeof(U));
                b.buffer = buffer.data();

                if constexpr (std::is_same_v<U, int8> || std::is_same_v<U, uint8> || std::is_same_v<U, bool>)
                {
                    b.buffer_type = MYSQL_TYPE_TINY;
                }
                else if constexpr (std::is_same_v<U, int16> || std::is_same_v<U, uint16>)
                {
                    b.buffer_type = MYSQL_TYPE_SHORT;
                }
                else if constexpr (std::is_same_v<U, int32> || std::is_same_v<U, uint32>)
                {
                    b.buffer_type = MYSQL_TYPE_LONG;
                }
                else if constexpr (std::is_same_v<U, float>)
                {
                    b.buffer_type = MYSQL_TYPE_FLOAT;
                }
                else if constexpr (std::is_same_v<U, double>)
                {
                    b.buffer_type = MYSQL_TYPE_DOUBLE;
                }

                b.is_unsigned = std::is_unsigned_v<U> ? 1 : 0;
            }
        },
        value);
}

auto db::LibMariaDBPreparedStatement::applyBindings() -> void
{
    if (!paramBinds_.empty())
    {
        if (mysql_stmt_bind_param(stmt_, paramBinds_.data()) != 0)
        {
            throw detail::libmariadb::Error(mysql_stmt_errno(stmt_), mysql_stmt_error(stmt_));
        }
    }
}

auto db::LibMariaDBPreparedStatement::resetBindings() -> void
{
    paramBinds_.clear();
    paramBuffers_.clear();
    paramLengths_.clear();
}

auto db::LibMariaDBPreparedStatement::ensureSchema() -> void
{
    if (schemaInitialized_)
    {
        return;
    }

    auto schema = std::make_shared<ColumnSchema>();
    kinds_.clear();

    const std::unique_ptr<MYSQL_RES, decltype(&mysql_free_result)> meta(mysql_stmt_result_metadata(stmt_), &mysql_free_result);
    if (meta != nullptr)
    {
        const unsigned int ncol   = mysql_num_fields(meta.get());
        MYSQL_FIELD*       fields = mysql_fetch_fields(meta.get());

        schema->names.reserve(ncol);
        kinds_.reserve(ncol);
        for (unsigned int i = 0; i < ncol; ++i)
        {
            std::string name(fields[i].name, fields[i].name_length);
            schema->index[name] = i;
            schema->names.push_back(std::move(name));

            switch (fields[i].type)
            {
                case MYSQL_TYPE_TINY:
                case MYSQL_TYPE_SHORT:
                case MYSQL_TYPE_LONG:
                case MYSQL_TYPE_INT24:
                case MYSQL_TYPE_LONGLONG:
                case MYSQL_TYPE_YEAR:
                    kinds_.push_back((fields[i].flags & UNSIGNED_FLAG) ? CellKind::UInt64 : CellKind::Int64);
                    break;
                case MYSQL_TYPE_FLOAT:
                case MYSQL_TYPE_DOUBLE:
                    kinds_.push_back(CellKind::Double);
                    break;
                default:
                    // DECIMAL/NEWDECIMAL, dates/times, CHAR/VARCHAR, BLOB, etc. are kept as text.
                    kinds_.push_back(CellKind::Text);
                    break;
            }
        }
    }

    schema_            = std::move(schema);
    schemaInitialized_ = true;
}

auto db::LibMariaDBPreparedStatement::fetchRows() -> std::vector<LibMariaDBResultSet::Row>
{
    const std::size_t ncol = kinds_.size();
    if (ncol == 0)
    {
        return {};
    }

    // Bind each column in its native form (8-byte numerics, a scratch buffer for text).
    std::vector<std::vector<char>> buffers(ncol);
    std::vector<unsigned long>     lengths(ncol, 0);
    std::vector<my_bool>           nulls(ncol, 0);
    std::vector<my_bool>           errors(ncol, 0);
    std::vector<MYSQL_BIND>        outBinds(ncol);
    for (std::size_t i = 0; i < ncol; ++i)
    {
        std::memset(&outBinds[i], 0, sizeof(MYSQL_BIND));
        outBinds[i].is_null = &nulls[i];
        outBinds[i].error   = &errors[i];
        outBinds[i].length  = &lengths[i];

        switch (kinds_[i])
        {
            case CellKind::Int64:
            case CellKind::UInt64:
                buffers[i].resize(sizeof(int64));
                outBinds[i].buffer_type = MYSQL_TYPE_LONGLONG;
                outBinds[i].is_unsigned = (kinds_[i] == CellKind::UInt64) ? 1 : 0;
                break;
            case CellKind::Double:
                buffers[i].resize(sizeof(double));
                outBinds[i].buffer_type = MYSQL_TYPE_DOUBLE;
                break;
            case CellKind::Text:
                buffers[i].resize(kInitialColumnBuffer);
                outBinds[i].buffer_type   = MYSQL_TYPE_STRING;
                outBinds[i].buffer_length = kInitialColumnBuffer;
                break;
        }

        outBinds[i].buffer = buffers[i].data();
    }

    if (mysql_stmt_bind_result(stmt_, outBinds.data()) != 0)
    {
        throw detail::libmariadb::Error(mysql_stmt_errno(stmt_), mysql_stmt_error(stmt_));
    }

    if (mysql_stmt_store_result(stmt_) != 0)
    {
        throw detail::libmariadb::Error(mysql_stmt_errno(stmt_), mysql_stmt_error(stmt_));
    }

    std::vector<LibMariaDBResultSet::Row> rows;
    rows.reserve(static_cast<std::size_t>(mysql_stmt_num_rows(stmt_)));

    for (;;)
    {
        const int rc = mysql_stmt_fetch(stmt_);
        if (rc == MYSQL_NO_DATA)
        {
            break;
        }
        if (rc == 1)
        {
            throw detail::libmariadb::Error(mysql_stmt_errno(stmt_), mysql_stmt_error(stmt_));
        }

        // rc == 0 (success) or MYSQL_DATA_TRUNCATED
        LibMariaDBResultSet::Row row(ncol);
        for (std::size_t i = 0; i < ncol; ++i)
        {
            if (nulls[i] != 0)
            {
                row[i] = std::monostate{};
                continue;
            }

            switch (kinds_[i])
            {
                case CellKind::Int64:
                {
                    int64 value = 0;
                    std::memcpy(&value, buffers[i].data(), sizeof(value));
                    row[i] = value;
                    break;
                }
                case CellKind::UInt64:
                {
                    uint64 value = 0;
                    std::memcpy(&value, buffers[i].data(), sizeof(value));
                    row[i] = value;
                    break;
                }
                case CellKind::Double:
                {
                    double value = 0.0;
                    std::memcpy(&value, buffers[i].data(), sizeof(value));
                    row[i] = value;
                    break;
                }
                case CellKind::Text:
                {
                    const unsigned long actualLen = lengths[i];
                    if (actualLen > buffers[i].size())
                    {
                        // Value truncated into the fixed buffer; fetch the full column.
                        std::vector<char> big(actualLen);
                        MYSQL_BIND        colBind;
                        std::memset(&colBind, 0, sizeof(colBind));
                        unsigned long colLen  = 0;
                        my_bool       colNull = 0;
                        my_bool       colErr  = 0;
                        colBind.buffer_type   = MYSQL_TYPE_STRING;
                        colBind.buffer        = big.data();
                        colBind.buffer_length = actualLen;
                        colBind.length        = &colLen;
                        colBind.is_null       = &colNull;
                        colBind.error         = &colErr;

                        if (mysql_stmt_fetch_column(stmt_, &colBind, static_cast<unsigned int>(i), 0) != 0)
                        {
                            throw detail::libmariadb::Error(mysql_stmt_errno(stmt_), mysql_stmt_error(stmt_));
                        }

                        row[i] = std::string(big.data(), actualLen);
                    }
                    else
                    {
                        row[i] = std::string(buffers[i].data(), actualLen);
                    }
                    break;
                }
            }
        }

        rows.push_back(std::move(row));
    }

    return rows;
}

auto db::LibMariaDBPreparedStatement::executeQuery(const std::string& query) -> std::unique_ptr<ResultSet>
{
    try
    {
        applyBindings();

        if (mysql_stmt_execute(stmt_) != 0)
        {
            throw detail::libmariadb::Error(mysql_stmt_errno(stmt_), mysql_stmt_error(stmt_));
        }

        ensureSchema();
        auto rows = fetchRows();

        resetBindings();
        return std::make_unique<LibMariaDBResultSet>(query, schema_, std::move(rows));
    }
    catch (...)
    {
        resetBindings();
        throw;
    }
}

auto db::LibMariaDBPreparedStatement::executeUpdate(const std::string& query) -> std::unique_ptr<ResultSet>
{
    try
    {
        applyBindings();

        if (mysql_stmt_execute(stmt_) != 0)
        {
            throw detail::libmariadb::Error(mysql_stmt_errno(stmt_), mysql_stmt_error(stmt_));
        }

        const auto affected = mysql_stmt_affected_rows(stmt_);
        resetBindings();
        return std::make_unique<LibMariaDBResultSet>(static_cast<std::size_t>(affected), query);
    }
    catch (...)
    {
        resetBindings();
        throw;
    }
}
