/////////////////////////////////////////////////////////////////////////////
//
// TwitMySong.cpp : Implementation of CTwitMySong
// Copyright (c) Microsoft Corporation. All rights reserved.
//
/////////////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "TwitMySong.h"

/////////////////////////////////////////////////////////////////////////////
// CTwitMySong::CTwitMySong
// Constructor

CTwitMySong::CTwitMySong()
{
    m_dwAdviseCookie = 0;
}

/////////////////////////////////////////////////////////////////////////////
// CTwitMySong::~CTwitMySong
// Destructor

CTwitMySong::~CTwitMySong()
{
}

/////////////////////////////////////////////////////////////////////////////
// CTwitMySong:::FinalConstruct
// Called when an plugin is first loaded. Use this function to do one-time
// intializations that could fail instead of doing this in the constructor,
// which cannot return an error.

HRESULT CTwitMySong::FinalConstruct()
{
    return S_OK;
}

/////////////////////////////////////////////////////////////////////////////
// CTwitMySong:::FinalRelease
// Called when a plugin is unloaded. Use this function to free any
// resources allocated in FinalConstruct.

void CTwitMySong::FinalRelease()
{
    ReleaseCore();
}

/////////////////////////////////////////////////////////////////////////////
// CTwitMySong::SetCore
// Set WMP core interface

HRESULT CTwitMySong::SetCore(IWMPCore *pCore)
{
    HRESULT hr = S_OK;

    // release any existing WMP core interfaces
    ReleaseCore();

    // If we get passed a NULL core, this  means
    // that the plugin is being shutdown.

    if (pCore == NULL)
    {
        return S_OK;
    }

    m_spCore = pCore;

    // connect up the event interface
    CComPtr<IConnectionPointContainer>  spConnectionContainer;

    hr = m_spCore->QueryInterface( &spConnectionContainer );

    if (SUCCEEDED(hr))
    {
        hr = spConnectionContainer->FindConnectionPoint( __uuidof(IWMPEvents), &m_spConnectionPoint );
    }

    if (SUCCEEDED(hr))
    {
        hr = m_spConnectionPoint->Advise( GetUnknown(), &m_dwAdviseCookie );

        if ((FAILED(hr)) || (0 == m_dwAdviseCookie))
        {
            m_spConnectionPoint = NULL;
        }
    }

    return hr;
}

/////////////////////////////////////////////////////////////////////////////
// CTwitMySong::ReleaseCore
// Release WMP core interfaces

void CTwitMySong::ReleaseCore()
{
    if (m_spConnectionPoint)
    {
        if (0 != m_dwAdviseCookie)
        {
            m_spConnectionPoint->Unadvise(m_dwAdviseCookie);
            m_dwAdviseCookie = 0;
        }
        m_spConnectionPoint = NULL;
    }

    if (m_spCore)
    {
        m_spCore = NULL;
    }
}





/////////////////////////////////////////////////////////////////////////////
// CTwitMySong::GetProperty
// Get plugin property

HRESULT CTwitMySong::GetProperty(const WCHAR *pwszName, VARIANT *pvarProperty)
{
    if (NULL == pvarProperty)
    {
        return E_POINTER;
    }

    return E_NOTIMPL;
}

/////////////////////////////////////////////////////////////////////////////
// CTwitMySong::SetProperty
// Set plugin property

HRESULT CTwitMySong::SetProperty(const WCHAR *pwszName, const VARIANT *pvarProperty)
{
    return E_NOTIMPL;
}
