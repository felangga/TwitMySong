        ��  ��                  %  0   R E G I S T R Y   ��e       0	        HKCR
{
	NoRemove CLSID
	{
		ForceRemove {EC14E9EB-C1AB-4610-B818-E093CC472A9B} = s 'TwitMySong Class'
		{
			InprocServer32 = s '%MODULE%'
			{
				val ThreadingModel = s 'Apartment'
			}
		}
	}
}
HKEY_LOCAL_MACHINE
{
    NoRemove SOFTWARE
    {
        NoRemove Microsoft
        {
            NoRemove MediaPlayer
            {
                NoRemove UIPlugins
                {
                    ForceRemove {EC14E9EB-C1AB-4610-B818-E093CC472A9B}
                    {
                        val FriendlyName = s 'res://TwitMySong.dll/RT_STRING/#102'
                        val Description = s 'res://TwitMySong.dll/RT_STRING/#103'
                        val Capabilities = d '3758096385'
                    }
                }
            }
        }
    }
}
   �       �� ��     0	                     T w i t M y S o n g   P l u g i n , S h a r e   y o u r   f a v o r i t e   s o n g s   t o   y o u r   f o l l o w e r s .                   