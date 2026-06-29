# ToriiBackendGenerated::ServerUserResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Unique identifier for this user. |  |
| **environment_id** | **String** | Identifier of the environment this user belongs to. |  |
| **name** | **String** | Full name on the profile, if any. | [optional] |
| **first_name** | **String** | First (given) name on the profile, if any. | [optional] |
| **last_name** | **String** | Last (family) name on the profile, if any. | [optional] |
| **locale** | **String** | Preferred locale for emails and UI messages. | [optional] |
| **status** | **String** | Lifecycle status of the user (e.g. active, banned). |  |
| **created_at** | **Time** | When this user was created (ISO-8601 UTC). |  |
| **updated_at** | **Time** | When this user was last modified (ISO-8601 UTC). |  |
| **email** | **String** | Primary email on the profile, if any. | [optional] |
| **email_verified_at** | **Time** | When this user&#39;s primary email was verified, if it has been verified. | [optional] |
| **deleted_at** | **Time** | When this user was deleted, if soft-deleted. Null for active users. | [optional] |
| **public_metadata** | **Hash&lt;String, Object&gt;** | Public metadata: readable by the SDK, writable only server-side. |  |
| **private_metadata** | **Hash&lt;String, Object&gt;** | Private metadata: server-only. Never exposed to the SDK or in a JWT. |  |
| **unsafe_metadata** | **Hash&lt;String, Object&gt;** | Unsafe metadata: readable and writable by the end-user via the SDK. |  |

## Example

```ruby
require 'torii_backend_generated'

instance = ToriiBackendGenerated::ServerUserResponse.new(
  id: 01931a73-8b00-7000-8000-000000000000,
  environment_id: 01931a72-0000-7000-8000-000000000000,
  name: Ada Lovelace,
  first_name: Ada,
  last_name: Lovelace,
  locale: null,
  status: null,
  created_at: 2026-05-16T09:30:00Z,
  updated_at: 2026-05-16T10:00:00Z,
  email: ada@example.com,
  email_verified_at: 2026-05-16T09:35:00Z,
  deleted_at: 2026-05-20T12:00:00Z,
  public_metadata: {plan&#x3D;pro},
  private_metadata: {billingCustomerId&#x3D;cus_123},
  unsafe_metadata: {onboardingStep&#x3D;2}
)
```

