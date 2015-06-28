{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE TypeFamilies      #-}

-- Module      : Network.AWS.Glacier.ListMultipartUploads
-- Copyright   : (c) 2013-2015 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- | This operation lists in-progress multipart uploads for the specified
-- vault. An in-progress multipart upload is a multipart upload that has
-- been initiated by an InitiateMultipartUpload request, but has not yet
-- been completed or aborted. The list returned in the List Multipart
-- Upload response has no guaranteed order.
--
-- The List Multipart Uploads operation supports pagination. By default,
-- this operation returns up to 1,000 multipart uploads in the response.
-- You should always check the response for a @marker@ at which to continue
-- the list; if there are no more items the @marker@ is @null@. To return a
-- list of multipart uploads that begins at a specific upload, set the
-- @marker@ request parameter to the value you obtained from a previous
-- List Multipart Upload request. You can also limit the number of uploads
-- returned in the response by specifying the @limit@ parameter in the
-- request.
--
-- Note the difference between this operation and listing parts
-- (ListParts). The List Multipart Uploads operation lists all multipart
-- uploads for a vault and does not require a multipart upload ID. The List
-- Parts operation requires a multipart upload ID since parts are
-- associated with a single upload.
--
-- An AWS account has full permission to perform all operations (actions).
-- However, AWS Identity and Access Management (IAM) users don\'t have any
-- permissions by default. You must grant them explicit permission to
-- perform specific actions. For more information, see
-- <http://docs.aws.amazon.com/amazonglacier/latest/dev/using-iam-with-amazon-glacier.html Access Control Using AWS Identity and Access Management (IAM)>.
--
-- For conceptual information and the underlying REST API, go to
-- <http://docs.aws.amazon.com/amazonglacier/latest/dev/working-with-archives.html Working with Archives in Amazon Glacier>
-- and
-- <http://docs.aws.amazon.com/amazonglacier/latest/dev/api-multipart-list-uploads.html List Multipart Uploads>
-- in the /Amazon Glacier Developer Guide/.
--
-- <http://docs.aws.amazon.com/amazonglacier/latest/dev/api-ListMultipartUploads.html>
module Network.AWS.Glacier.ListMultipartUploads
    (
    -- * Request
      ListMultipartUploads
    -- ** Request constructor
    , listMultipartUploads
    -- ** Request lenses
    , lmuMarker
    , lmuLimit
    , lmuAccountId
    , lmuVaultName

    -- * Response
    , ListMultipartUploadsResponse
    -- ** Response constructor
    , listMultipartUploadsResponse
    -- ** Response lenses
    , lmurUploadsList
    , lmurMarker
    , lmurStatus
    ) where

import           Network.AWS.Glacier.Types
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | Provides options for retrieving list of in-progress multipart uploads
-- for an Amazon Glacier vault.
--
-- /See:/ 'listMultipartUploads' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lmuMarker'
--
-- * 'lmuLimit'
--
-- * 'lmuAccountId'
--
-- * 'lmuVaultName'
data ListMultipartUploads = ListMultipartUploads'
    { _lmuMarker    :: !(Maybe Text)
    , _lmuLimit     :: !(Maybe Text)
    , _lmuAccountId :: !Text
    , _lmuVaultName :: !Text
    } deriving (Eq,Read,Show)

-- | 'ListMultipartUploads' smart constructor.
listMultipartUploads :: Text -> Text -> ListMultipartUploads
listMultipartUploads pAccountId pVaultName =
    ListMultipartUploads'
    { _lmuMarker = Nothing
    , _lmuLimit = Nothing
    , _lmuAccountId = pAccountId
    , _lmuVaultName = pVaultName
    }

-- | An opaque string used for pagination. This value specifies the upload at
-- which the listing of uploads should begin. Get the marker value from a
-- previous List Uploads response. You need only include the marker if you
-- are continuing the pagination of results started in a previous List
-- Uploads request.
lmuMarker :: Lens' ListMultipartUploads (Maybe Text)
lmuMarker = lens _lmuMarker (\ s a -> s{_lmuMarker = a});

-- | Specifies the maximum number of uploads returned in the response body.
-- If this value is not specified, the List Uploads operation returns up to
-- 1,000 uploads.
lmuLimit :: Lens' ListMultipartUploads (Maybe Text)
lmuLimit = lens _lmuLimit (\ s a -> s{_lmuLimit = a});

-- | The @AccountId@ value is the AWS account ID of the account that owns the
-- vault. You can either specify an AWS account ID or optionally a single
-- apos@-@apos (hyphen), in which case Amazon Glacier uses the AWS account
-- ID associated with the credentials used to sign the request. If you use
-- an account ID, do not include any hyphens (apos-apos) in the ID.
lmuAccountId :: Lens' ListMultipartUploads Text
lmuAccountId = lens _lmuAccountId (\ s a -> s{_lmuAccountId = a});

-- | The name of the vault.
lmuVaultName :: Lens' ListMultipartUploads Text
lmuVaultName = lens _lmuVaultName (\ s a -> s{_lmuVaultName = a});

instance AWSRequest ListMultipartUploads where
        type Sv ListMultipartUploads = Glacier
        type Rs ListMultipartUploads =
             ListMultipartUploadsResponse
        request = get
        response
          = receiveJSON
              (\ s h x ->
                 ListMultipartUploadsResponse' <$>
                   (x .?> "UploadsList" .!@ mempty) <*> (x .?> "Marker")
                     <*> (pure s))

instance ToHeaders ListMultipartUploads where
        toHeaders = const mempty

instance ToPath ListMultipartUploads where
        toPath ListMultipartUploads'{..}
          = mconcat
              ["/", toText _lmuAccountId, "/vaults/",
               toText _lmuVaultName, "/multipart-uploads"]

instance ToQuery ListMultipartUploads where
        toQuery ListMultipartUploads'{..}
          = mconcat
              ["marker" =: _lmuMarker, "limit" =: _lmuLimit]

-- | Contains the Amazon Glacier response to your request.
--
-- /See:/ 'listMultipartUploadsResponse' smart constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'lmurUploadsList'
--
-- * 'lmurMarker'
--
-- * 'lmurStatus'
data ListMultipartUploadsResponse = ListMultipartUploadsResponse'
    { _lmurUploadsList :: !(Maybe [UploadListElement])
    , _lmurMarker      :: !(Maybe Text)
    , _lmurStatus      :: !Status
    } deriving (Eq,Read,Show)

-- | 'ListMultipartUploadsResponse' smart constructor.
listMultipartUploadsResponse :: Status -> ListMultipartUploadsResponse
listMultipartUploadsResponse pStatus =
    ListMultipartUploadsResponse'
    { _lmurUploadsList = Nothing
    , _lmurMarker = Nothing
    , _lmurStatus = pStatus
    }

-- | A list of in-progress multipart uploads.
lmurUploadsList :: Lens' ListMultipartUploadsResponse [UploadListElement]
lmurUploadsList = lens _lmurUploadsList (\ s a -> s{_lmurUploadsList = a}) . _Default;

-- | An opaque string that represents where to continue pagination of the
-- results. You use the marker in a new List Multipart Uploads request to
-- obtain more uploads in the list. If there are no more uploads, this
-- value is @null@.
lmurMarker :: Lens' ListMultipartUploadsResponse (Maybe Text)
lmurMarker = lens _lmurMarker (\ s a -> s{_lmurMarker = a});

-- | FIXME: Undocumented member.
lmurStatus :: Lens' ListMultipartUploadsResponse Status
lmurStatus = lens _lmurStatus (\ s a -> s{_lmurStatus = a});
