if(NOT WIN32)
    message(STATUS "Building MariaDB Connector/C++ from source")
    CPMAddPackage(
        NAME mariadb-connector-cpp
        GITHUB_REPOSITORY zach2good/mariadb-connector-cpp
        GIT_TAG 1e4b414b49fc8e346fab4b1718aaaf2eadacde2e
        DOWNLOAD_ONLY YES
    )
    if(mariadb-connector-cpp_ADDED)
        set(PROJECT_VERSION_MAJOR 0)
        set(PROJECT_VERSION_MINOR 0)
        set(PROJECT_VERSION_PATCH 0)

        configure_file(
            ${mariadb-connector-cpp_SOURCE_DIR}/src/Version.h.in
            ${mariadb-connector-cpp_SOURCE_DIR}/src/Version.h
        )

        configure_file(
            ${mariadb-connector-cpp_SOURCE_DIR}/src/maconncpp.def.in
            ${mariadb-connector-cpp_SOURCE_DIR}/src/maconncpp.def
        )

        set(MACPP_SOURCES
            ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbDriver.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/DriverManager.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/UrlParser.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbDatabaseMetaData.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/HostAddress.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/Consts.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/SQLString.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbConnection.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbStatement.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDBException.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDBWarning.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/Identifier.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbSavepoint.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/SqlStates.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/Results.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/ColumnType.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/ColumnDefinition.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/protocol/MasterProtocol.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/protocol/capi/QueryProtocol.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/protocol/capi/ConnectProtocol.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/com/capi/ColumnDefinitionCapi.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/cache/CallableStatementCache.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/cache/CallableStatementCacheKey.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/util/Value.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/util/Utils.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/util/String.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/logger/NoLogger.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/logger/LoggerFactory.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/logger/ProtocolLoggingProxy.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/ParameterHolder.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/options/Options.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/options/DefaultOptions.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/pool/GlobalStateInfo.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/pool/Pools.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/failover/FailoverProxy.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/credential/CredentialPluginLoader.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/SelectResultSet.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/com/capi/SelectResultSetCapi.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/com/ColumnNameMap.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/io/StandardPacketInputStream.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/Charset.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/ClientSidePreparedStatement.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/BasePrepareStatement.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbFunctionStatement.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbProcedureStatement.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/ServerSidePreparedStatement.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/BigDecimalParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/BooleanParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/ByteArrayParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/ByteParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/DateParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/DefaultParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/DoubleParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/FloatParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/IntParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/LongParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/ULongParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/NullParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/ParameterHolder.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/ReaderParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/ShortParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/StreamParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/TimeParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/TimestampParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/StringParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbPooledConnection.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbParameterMetaData.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbResultSetMetaData.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/CallParameter.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/CallableParameterMetaData.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/com/Packet.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/credential/Credential.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/util/LogQueryTool.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/util/ClientPrepareResult.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/util/ServerPrepareResult.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/util/ServerPrepareStatementCache.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/com/CmdInformationSingle.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/com/CmdInformationBatch.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/com/CmdInformationMultiple.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/com/RowProtocol.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/protocol/capi/BinRowProtocolCapi.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/protocol/capi/TextRowProtocolCapi.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/ExceptionFactory.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/StringImp.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/CArray.cpp
            ${mariadb-connector-cpp_SOURCE_DIR}/src/SimpleParameterMetaData.cpp
        )

        # NOTE: Keep this around if we ever want to rebuild the mariadb-connector-cpp library
        if(WIN32)
            set(MACPP_SOURCES
                ${MACPP_SOURCES}
                ${mariadb-connector-cpp_SOURCE_DIR}/src/Dll.c
                ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDBConnCpp.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbDriver.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/UrlParser.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbDatabaseMetaData.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/HostAddress.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/Version.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/Consts.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbConnection.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbStatement.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDBWarning.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/Protocol.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/Identifier.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbSavepoint.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/SqlStates.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/Results.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/ColumnDefinition.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbServerCapabilities.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/protocol/MasterProtocol.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/protocol/capi/QueryProtocol.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/protocol/capi/ConnectProtocol.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/com/capi/ColumnDefinitionCapi.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/cache/CallableStatementCache.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/cache/CallableStatementCacheKey.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/util/Value.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/util/ClassField.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/util/Utils.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/util/StateChange.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/util/String.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/logger/NoLogger.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/logger/LoggerFactory.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/logger/Logger.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/logger/ProtocolLoggingProxy.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/ParameterHolder.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/options/Options.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/options/DefaultOptions.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/options/DriverPropertyInfo.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/io/PacketOutputStream.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/io/PacketInputStream.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/io/StandardPacketInputStream.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/credential/CredentialPlugin.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/credential/CredentialPluginLoader.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/pool/GlobalStateInfo.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/pool/Pools.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/pool/Pool.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/failover/FailoverProxy.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/Listener.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/com/CmdInformation.h
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/Connection.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/Statement.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/ResultSet.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/PreparedStatement.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/ParameterMetaData.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/ResultSetMetaData.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/DatabaseMetaData.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/CallableStatement.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/SQLString.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/Warning.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/Exception.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/jdbccompat.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/Driver.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/DriverManager.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/Types.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/buildconf.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp/CArray.hpp
                ${mariadb-connector-cpp_SOURCE_DIR}/src/SelectResultSet.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/com/capi/SelectResultSetCapi.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/com/SelectResultSetPacket.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/ColumnType.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/com/ColumnDefinitionPacket.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/com/ColumnNameMap.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/Charset.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/ClientSidePreparedStatement.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/BasePrepareStatement.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbFunctionStatement.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbProcedureStatement.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/ServerSidePreparedStatement.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/BigDecimalParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/BooleanParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/ByteArrayParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/ByteParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/DateParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/DefaultParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/DoubleParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/FloatParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/IntParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/LongParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/ULongParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/NullParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/ReaderParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/ShortParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/StreamParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/TimeParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/TimestampParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/parameters/StringParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/Parameters.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbPooledConnection.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbParameterMetaData.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/CallParameter.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/CallableParameterMetaData.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/MariaDbResultSetMetaData.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/com/Packet.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/util/ServerStatus.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/credential/Credential.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/util/LogQueryTool.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/PrepareResult.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/util/ClientPrepareResult.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/util/ServerPrepareResult.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/util/ServerPrepareStatementCache.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/com/CmdInformationSingle.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/com/CmdInformationBatch.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/com/CmdInformationMultiple.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/com/RowProtocol.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/protocol/capi/BinRowProtocolCapi.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/protocol/capi/TextRowProtocolCapi.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/ExceptionFactory.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/StringImp.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/CArrayImp.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/SimpleParameterMetaData.h
                ${mariadb-connector-cpp_SOURCE_DIR}/src/maconncpp.def
            )
        endif()
        add_library(mariadbclientcpp STATIC ${MACPP_SOURCES})
        target_include_directories(mariadbclientcpp
            PUBLIC
                ${mariadb-connector-cpp_SOURCE_DIR}/include
            PRIVATE
                ${mariadb-connector-cpp_SOURCE_DIR}/include/conncpp
                ${mariadb-connector-cpp_SOURCE_DIR}/src/
        )
        target_link_libraries(mariadbclientcpp PRIVATE mariadbclient)

        set(MARIADBCPP_FOUND TRUE)
        set(MARIADBCPP_LIBRARY mariadbclientcpp)
        set(MARIADBCPP_INCLUDE_DIR ${mariadb-connector-cpp_SOURCE_DIR}/include)
    endif()
else() # WIN32
    message(STATUS "Looking for prebuilt MariaDB Connector/C++")
    find_library(MARIADBCPP_LIBRARY
        NAMES
            mariadbcpp
        PATHS
            ${PROJECT_SOURCE_DIR}/ext/mariadbcpp/${lib_dir}/
    )

    set(MARIADBCPP_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/ext/mariadbcpp/include/) # Only look internally

    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(MariaDBCPP DEFAULT_MSG MARIADBCPP_LIBRARY MARIADBCPP_INCLUDE_DIR)
endif()

message(STATUS "MARIADBCPP_FOUND: ${MARIADBCPP_FOUND}")
message(STATUS "MARIADBCPP_LIBRARY: ${MARIADBCPP_LIBRARY}")
message(STATUS "MARIADBCPP_INCLUDE_DIR: ${MARIADBCPP_INCLUDE_DIR}")

add_library(mariadbcpp INTERFACE)
target_link_libraries(mariadbcpp INTERFACE ${MARIADBCPP_LIBRARY})
target_include_directories(mariadbcpp SYSTEM INTERFACE ${MARIADBCPP_INCLUDE_DIR})
