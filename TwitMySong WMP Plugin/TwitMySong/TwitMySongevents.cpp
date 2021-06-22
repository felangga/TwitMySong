/////////////////////////////////////////////////////////////////////////////
//
// TwitMySongEvents.cpp : Implementation of CTwitMySong events
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//
/////////////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "TwitMySong.h"
#include <fstream>
#include <sstream>


void CTwitMySong::OpenStateChange( long NewState )
{
    switch (NewState)
    {
    case wmposUndefined:
        break;
    case wmposPlaylistChanging:
        break;
    case wmposPlaylistLocating:
        break;
    case wmposPlaylistConnecting:
        break;
    case wmposPlaylistLoading:
        break;
    case wmposPlaylistOpening:
        break;
    case wmposPlaylistOpenNoMedia:
        break;
    case wmposPlaylistChanged:
        break;
    case wmposMediaChanging:
        break;
    case wmposMediaLocating:
        break;
    case wmposMediaConnecting:
        break;
    case wmposMediaLoading:
        break;
    case wmposMediaOpening:
        break;
    case wmposMediaOpen:
        break;
    case wmposBeginCodecAcquisition:
        break;
    case wmposEndCodecAcquisition:
        break;
    case wmposBeginLicenseAcquisition:
        break;
    case wmposEndLicenseAcquisition:
        break;
    case wmposBeginIndividualization:
        break;
    case wmposEndIndividualization:
        break;
    case wmposMediaWaiting:
        break;
    case wmposOpeningUnknownURL:
        break;
    default:
        break;
    }
}

void CTwitMySong::PlayStateChange( long NewState )
{
	BOOL sukses = FALSE;
	TCHAR temp_file[255+9];
	TCHAR temp_file2[255+9];
	TCHAR temppath[MAX_PATH];

	// Cari path folder temporary (%temp%) berada simpan pada variabel temp_file
	GetTempPath(MAX_PATH, temppath);
	lstrcpy(temp_file, temppath);
	lstrcpy(temp_file2, temppath);
	lstrcat(temp_file2, TEXT("wmp.txt"));
	lstrcat(temp_file, TEXT("wmpplugin.txt"));

    switch (NewState)
    {
    case wmppsUndefined:
        break;
    case wmppsStopped: {
		sukses = MoveFile(temp_file, temp_file2);
	   } break;
    case wmppsPaused:
        break;
    case wmppsPlaying:
		sukses = MoveFile(temp_file2, temp_file);
        break;
    case wmppsScanForward:
        break;
    case wmppsScanReverse:
        break;
    case wmppsBuffering:
        break;
    case wmppsWaiting:
        break;
    case wmppsMediaEnded:
        break;
    case wmppsTransitioning:
        break;
    case wmppsReady:
        break;
    case wmppsReconnecting:
        break;
    case wmppsLast:
        break;
    default:
        break;
    }
}

void CTwitMySong::AudioLanguageChange( long LangID )
{
}

void CTwitMySong::StatusChange()
{
}

void CTwitMySong::ScriptCommand( BSTR scType, BSTR Param )
{
}

void CTwitMySong::NewStream()
{
}

void CTwitMySong::Disconnect( long Result )
{
}

void CTwitMySong::Buffering( VARIANT_BOOL Start )
{
}

void CTwitMySong::Error()
{
    CComPtr<IWMPError>      spError;
    CComPtr<IWMPErrorItem>  spErrorItem;
    HRESULT                 dwError = S_OK;
    HRESULT                 hr = S_OK;

    if (m_spCore)
    {
        hr = m_spCore->get_error(&spError);

        if (SUCCEEDED(hr))
        {
            hr = spError->get_item(0, &spErrorItem);
        }

        if (SUCCEEDED(hr))
        {
            hr = spErrorItem->get_errorCode( (long *) &dwError );
        }
    }
}

void CTwitMySong::Warning( long WarningType, long Param, BSTR Description )
{
}

void CTwitMySong::EndOfStream( long Result )
{
}

void CTwitMySong::PositionChange( double oldPosition, double newPosition)
{
}

void CTwitMySong::MarkerHit( long MarkerNum )
{
}

void CTwitMySong::DurationUnitChange( long NewDurationUnit )
{
}

void CTwitMySong::CdromMediaChange( long CdromNum )
{
}

void CTwitMySong::PlaylistChange( IDispatch * Playlist, WMPPlaylistChangeEventType change )
{
    switch (change)
    {
    case wmplcUnknown:
        break;
    case wmplcClear:
        break;
    case wmplcInfoChange:
        break;
    case wmplcMove:
        break;
    case wmplcDelete:
        break;
    case wmplcInsert:
        break;
    case wmplcAppend:
        break;
    case wmplcPrivate:
        break;
    case wmplcNameChange:
        break;
    case wmplcMorph:
        break;
    case wmplcSort:
        break;
    case wmplcLast:
        break;
    default:
        break;
    }
}

void CTwitMySong::CurrentPlaylistChange( WMPPlaylistChangeEventType change )
{
    switch (change)
    {
    case wmplcUnknown:
        break;
    case wmplcClear:
        break;
    case wmplcInfoChange:
        break;
    case wmplcMove:
        break;
    case wmplcDelete:
        break;
    case wmplcInsert:
        break;
    case wmplcAppend:
        break;
    case wmplcPrivate:
        break;
    case wmplcNameChange:
        break;
    case wmplcMorph:
        break;
    case wmplcSort:
        break;
    case wmplcLast:
        break;
    default:
        break;
    }
}

void CTwitMySong::CurrentPlaylistItemAvailable( BSTR bstrItemName )
{
}

void CTwitMySong::MediaChange( IDispatch * Item )
{
}

void CTwitMySong::CurrentMediaItemAvailable( BSTR bstrItemName )
{
}

void CTwitMySong::CurrentItemChange( IDispatch *pdispMedia)
{
	USES_CONVERSION;
    HRESULT hr = S_OK;
    IID guid;
	CComPtr<IWMPCore>           m_spCore;
    CComPtr<IConnectionPoint>   m_spConnectionPoint;
    CComPtr<IWMPPlayer>         m_pIWMPPlayer;
    CComPtr<IWMPMedia>          m_pIWMPMedia;
    CComPtr<IWMPControls>       m_pIWMPControls;
 
    if (m_pIWMPMedia == NULL)
    {
        guid = __uuidof(IWMPMedia);
        hr = pdispMedia->QueryInterface( guid, reinterpret_cast<void**>(&m_pIWMPMedia) );
        if (m_pIWMPMedia == NULL)
            ::MessageBoxA(NULL, "Failed to get pointer to IWMPMedia\n", NULL, MB_OK);
        else
        {	
			// Ambil informasi event dari Windows Media Player
            BSTR alamat;
			TCHAR temppath[MAX_PATH];
			TCHAR temp_file[255+9];

			// Cari path folder temporary (%temp%) berada simpan pada variabel temp_file
			GetTempPath(MAX_PATH, temppath);
			lstrcpy(temp_file, temppath);
			lstrcat(temp_file, TEXT("wmpplugin.txt"));
			
			// Ambil alamat mp3 yang sedang dimainkan
   			m_pIWMPMedia->get_sourceURL(&alamat);
			BSTR namaArtist;
			BSTR namaTrack;
			BSTR artist = SysAllocString(L"Artist");
			BSTR track  = SysAllocString(L"Name");

			m_pIWMPMedia->getItemInfo(artist, &namaArtist);
			m_pIWMPMedia->getItemInfo(track, &namaTrack);

			// Tulis ke file %temp%\\wmpplugin.txt
			std::ofstream outfile(temp_file);
			outfile 
				<< T2A(namaArtist) << "\n" << T2A(namaTrack)
			<< std::endl;

		}
    }
}

void CTwitMySong::MediaCollectionChange()
{
}

void CTwitMySong::MediaCollectionAttributeStringAdded( BSTR bstrAttribName,  BSTR bstrAttribVal )
{
}

void CTwitMySong::MediaCollectionAttributeStringRemoved( BSTR bstrAttribName,  BSTR bstrAttribVal )
{
}

void CTwitMySong::MediaCollectionAttributeStringChanged( BSTR bstrAttribName, BSTR bstrOldAttribVal, BSTR bstrNewAttribVal)
{
}

void CTwitMySong::PlaylistCollectionChange()
{
}

void CTwitMySong::PlaylistCollectionPlaylistAdded( BSTR bstrPlaylistName)
{
}

void CTwitMySong::PlaylistCollectionPlaylistRemoved( BSTR bstrPlaylistName)
{
}

void CTwitMySong::PlaylistCollectionPlaylistSetAsDeleted( BSTR bstrPlaylistName, VARIANT_BOOL varfIsDeleted)
{
}

void CTwitMySong::ModeChange( BSTR ModeName, VARIANT_BOOL NewValue)
{
}

void CTwitMySong::MediaError( IDispatch * pMediaObject)
{
}

void CTwitMySong::OpenPlaylistSwitch( IDispatch *pItem )
{
}

void CTwitMySong::DomainChange( BSTR strDomain)
{
}

void CTwitMySong::SwitchedToPlayerApplication()
{
}

void CTwitMySong::SwitchedToControl()
{
}

void CTwitMySong::PlayerDockedStateChange()
{
}

void CTwitMySong::PlayerReconnect()
{
}

void CTwitMySong::Click( short nButton, short nShiftState, long fX, long fY )
{
}

void CTwitMySong::DoubleClick( short nButton, short nShiftState, long fX, long fY )
{
}

void CTwitMySong::KeyDown( short nKeyCode, short nShiftState )
{
}

void CTwitMySong::KeyPress( short nKeyAscii )
{
}

void CTwitMySong::KeyUp( short nKeyCode, short nShiftState )
{
}

void CTwitMySong::MouseDown( short nButton, short nShiftState, long fX, long fY )
{
}

void CTwitMySong::MouseMove( short nButton, short nShiftState, long fX, long fY )
{
}

void CTwitMySong::MouseUp( short nButton, short nShiftState, long fX, long fY )
{
}
